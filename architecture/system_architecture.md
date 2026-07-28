# NetBird System Architecture & Component Specification

This document details the internal architecture, service interactions, signaling protocol, data layer, and network encapsulation model for NetBird.

---

## Service Component Breakdown

```text
+-------------------------------------------------------------------------+
|                        NETBIRD CONTROL PLANE                            |
|                                                                         |
|  +------------------+   +-------------------+   +--------------------+  |
|  |  Dashboard UI    |   | Management API    |   | Signal Service     |  |
|  | (React / Web)    |   | (gRPC / SQLite)   |   | (Peer Exchange)    |  |
|  +--------+---------+   +---------+---------+   +---------+----------+  |
|           |                       |                       |             |
+-----------|-----------------------|-----------------------|-------------+
            |                       |                       |
            +-----------------------+-----------------------+
                                    | TLS gRPC / HTTPS
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
|                                   |  | STUN / TURN                      |
|                                   v  v                                  |
|                         +-----------------------+                       |
|                         | Coturn Relay Server   |                       |
|                         | (Port 3478 UDP/TCP)   |                       |
|                         +-----------------------+                       |
+-------------------------------------------------------------------------+
```

---

## Detailed Component Specifications

1. **Management Service (`netbirdio/management`):**
   - Central control plane maintaining state, peer registration, setup keys, ACL access control rules, and network routes.
   - Listens on gRPC port `33073`.

2. **Signal Service (`netbirdio/signal`):**
   - High-performance, lightweight signaling server facilitating WireGuard peer endpoint negotiation for NAT hole punching.
   - Listens on gRPC port `10000`.

3. **Coturn Relay Service (`coturn/coturn`):**
   - STUN / TURN server used to establish fallback relay channels when direct P2P connections fail due to restrictive NATs.
   - Listens on UDP/TCP port `3478`.

4. **Dashboard Web Interface (`netbirdio/dashboard`):**
   - Admin Web UI for visualizing peers, managing setup keys, configuring network routes, and monitoring real-time network state.
