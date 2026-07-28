# NetBird Network Topology & WireGuard Mesh Architecture

This document describes the overlay network topology, addressing plan, direct WireGuard P2P connections, Relay fallback mechanisms, and STUN operation.

---

## 1. Network Overlay Topology Overview

NetBird builds an encrypted WireGuard peer-to-peer overlay network using the RFC 6598 Carrier-Grade NAT (CGNAT) address block (`100.64.0.0/10`).

```text
                        +----------------------------+
                        | Traefik HTTPS (Port 443)   |
                        | NetBird Server Container   |
                        +--------------+-------------+
                                       |
                   +-------------------+-------------------+
                   | gRPC Signaling & OAuth2 Authentication|
                   v                                       v
        +----------------------+                +----------------------+
        | Node A (Linux Server)| <============> | Node B (Client Peer) |
        | NetBird Mesh IP:     |   Direct P2P   | NetBird Mesh IP:     |
        | 100.64.0.1           | WireGuard UDP  | 100.64.0.2           |
        +----------------------+  Port 51820    +----------------------+
                   ^                                       ^
                   |                                       |
                   +--------------+  +---------------------+
                                  |  | Fallback Relay (WebSockets/QUIC)
                                  v  v
                        +----------------------+
                        | NetBird Server Relay |
                        | (Port 443 / 3478 UDP)|
                        +----------------------+
```

---

## 2. Peer Discovery, STUN & Relay Traversal

1. **Signaling Phase (HTTPS / gRPC 443):**
   Nodes authenticate with the NetBird Management API and exchange WireGuard public keys and endpoint IP/port candidates via the embedded Signal service.

2. **Direct WireGuard P2P Phase (UDP 51820):**
   Nodes send STUN queries to `3478/udp` to discover public NAT mappings. Nodes perform direct UDP hole-punching. When successful, packets travel directly peer-to-peer using ChaCha20-Poly1305 encryption.

3. **Embedded Relay Fallback Phase (HTTPS 443 WebSockets / QUIC):**
   If direct UDP hole-punching fails (e.g. strict symmetric NATs or corporate firewalls blocking outbound UDP), peers seamlessly fall back to tunneling WireGuard traffic through the NetBird Relay service via WebSockets over HTTPS (`443/tcp`).

---

## 3. CGNAT Addressing Scheme (`100.64.0.0/10`)

| Node Identifier | Role | NetBird Mesh IP | Subnet Netmask |
| :--- | :--- | :--- | :--- |
| **netbird-server.example.com** | Self-Hosted Server & Gateway | `100.64.0.1` | `255.255.0.0 (/16)` |
| **node-b.example.com** | Client Peer | `100.64.0.2` | `255.255.0.0 (/16)` |
| **node-c.example.com** | Client Peer | `100.64.0.3` | `255.255.0.0 (/16)` |
