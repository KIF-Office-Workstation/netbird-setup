# NetBird System Architecture & Combined Container Model

This document details the modern combined container architecture of NetBird, component service roles, relay fallback channels, and protocol flow.

---

## 1. Modern Architecture Overview

NetBird modern deployment consolidates signaling, management, relay, and STUN services into the single `netbirdio/netbird-server` container image.

```text
+-------------------------------------------------------------------------+
|                  NETBIRD COMBINED CONTROL PLANE STACK                   |
|                                                                         |
|  +-------------------------+            +----------------------------+  |
|  |  Dashboard Container    |            | Traefik Reverse Proxy      |  |
|  | (netbirdio/dashboard)   |            | Ports: 80/tcp, 443/tcp     |  |
|  +------------+------------+            +-------------+--------------+  |
|               |                                       |                 |
|               +-------------------+-------------------+                 |
|                                   |                                     |
|                                   v                                     |
|  +-------------------------------------------------------------------+  |
|  |  NetBird Combined Server Container (netbirdio/netbird-server)     |  |
|  |                                                                   |  |
|  |  [Embedded Management]  - Peer DB, Setup Keys, ACL Rules          |  |
|  |  [Embedded Signal]      - gRPC Peer Discovery                     |  |
|  |  [Embedded STUN]        - UDP Port 3478 NAT Hole-Punching          |  |
|  |  [Embedded Relay]       - WebSocket/QUIC Restrictive NAT Fallback  |  |
|  |  [Embedded Dex IdP]     - OIDC Authentication                     |  |
|  +-------------------------------------------------------------------+  |
|                                                                         |
+-------------------------------------------------------------------------+
                                    |
                                    v
+-------------------------------------------------------------------------+
|                         NETBIRD MESH NETWORK                            |
|                                                                         |
|       +-------------------+               +-------------------+         |
|       | Client Node A     |  WireGuard    | Client Node B     |         |
|       | (100.64.0.1)      |  P2P Tunnel   | (100.64.0.2)      |         |
|       | Interface: wt0    | <===========> | Interface: wt0    |         |
|       +---------+---------+               +---------+---------+         |
|                 |                                   |                   |
|                 +-----------------+  +--------------+                   |
|                                   |  | Relay Fallback (Port 443 / 3478) |
|                                   v  v                                  |
|                         +-----------------------+                       |
|                         | NetBird Server Relay  |                       |
|                         +-----------------------+                       |
+-------------------------------------------------------------------------+
```

---

## 2. Component Service Specifications

1. **Traefik Reverse Proxy (`traefik:v3.1`):**
   Handles incoming HTTP (80) and HTTPS (443) traffic, automates Let's Encrypt TLS issuance, and routes traffic to backend containers:
   - `/signalexchange.*` & `/management.*` -> gRPC cleartext (`h2c`) to `netbird-server:80`.
   - `/relay*` & `/ws-proxy/*` -> WebSocket upgrade to `netbird-server:80`.
   - `/api*` & `/oauth2*` -> HTTP proxy to `netbird-server:80`.
   - `/*` -> Dashboard UI container `netbird-dashboard:80`.

2. **NetBird Server Container (`netbirdio/netbird-server:latest`):**
   - **Management Engine:** Manages SQLite database (`/var/lib/netbird/management.db`), peer configurations, and setup keys.
   - **Signal Engine:** Negotiates WireGuard public keys and endpoint IP/port candidate pairs.
   - **STUN Engine:** Listens on `3478/udp` for NAT IP/port discovery.
   - **Relay Engine:** Handles encrypted WireGuard packet relay over WebSockets or QUIC when direct P2P connections are obstructed by restrictive enterprise firewalls.
   - **Embedded Identity Provider (Dex):** Provides OIDC authentication endpoints at `/oauth2`.

3. **NetBird Dashboard (`netbirdio/dashboard:latest`):**
   Web application interface for managing peers, networks, setup keys, and access control policies.

---

## 3. Connectivity & Fallback Hierarchy

1. **Direct WireGuard P2P (Primary Mode):**
   Peers establish a direct UDP `51820` tunnel using ChaCha20-Poly1305 encryption.
2. **Relay Fallback (Fallback Mode):**
   If direct UDP hole-punching fails due to symmetric NAT or firewall blocks, peers fall back to tunneling WireGuard frames through the NetBird Server Relay via HTTPS WebSockets over port `443`.
