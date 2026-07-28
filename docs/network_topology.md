# NetBird Network Topology & Overlay Architecture

This document describes the mesh network topology, peer discovery mechanism, NAT traversal strategy, and subnet routing model for the NetBird deployment.

---

## 1. Network Topology Overview

NetBird builds an encrypted **Peer-to-Peer (P2P) WireGuard Mesh Network** directly between connected client nodes.

```text
                        +----------------------------+
                        |  NetBird Control Plane     |
                        | (Management / Signal UI)   |
                        +--------------+-------------+
                                       |
                   +-------------------+-------------------+
                   | gRPC Signaling & Configuration        |
                   v                                       v
        +----------------------+                +----------------------+
        | Node A (Linux Server)| <============> |  Node B (WSL/Peer)   |
        | NetBird IP:          |   Direct P2P   | NetBird IP:          |
        | 100.64.0.1           | WireGuard UDP  | 100.64.0.2           |
        +----------------------+  Port 51820    +----------------------+
                   ^                                       ^
                   |                                       |
                   +--------------+  +---------------------+
                                  |  | Fallback STUN/TURN
                                  v  v
                        +----------------------+
                        | Coturn Relay Server  |
                        | (STUN / TURN 3478)   |
                        +----------------------+
```

---

## 2. Peer Discovery & Connection States

1. **Signaling Exchange (gRPC 10000):**
   When two nodes join the mesh, they negotiate WireGuard public keys and endpoint candidates via the NetBird Signal service.

2. **Direct P2P Establishment (UDP 51820):**
   Peers initiate direct hole-punching. If successful, connections bypass central servers, achieving maximum throughput and minimum latency.

3. **Fallback Relay (Coturn TURN 3478):**
   If symmetric NAT or enterprise firewalls prevent direct P2P hole punching, peers establish an end-to-end encrypted WireGuard connection proxied through Coturn TURN relay.

---

## 3. Overlay Addressing Plan (`100.64.0.0/10`)

NetBird uses the RFC 6598 Carrier-Grade NAT (CGNAT) address space (`100.64.0.0/10`):

| Node Identifier | Role | Public IP | NetBird Mesh IP | Subnet Netmask |
| :--- | :--- | :--- | :--- | :--- |
| **server.muhager.com** | Primary Server & Gateway | `178.105.49.9` | `100.64.0.1` | `255.255.0.0 (/16)` |
| **wsl-peer-01** | Development Peer | Local Subnet | `100.64.0.2` | `255.255.0.0 (/16)` |
| **win-host-01** | Admin Workstation | Local Subnet | `100.64.0.3` | `255.255.0.0 (/16)` |

---

## 4. Network Security & ACL Rules

- **Default Stance:** Zero-Trust Access Control.
- **Access Policies:** Configured via NetBird Admin Dashboard or Management API.
- **Port Isolation:** Untrusted peers cannot scan or access internal host services unless explicitly allowed by access control rules.
