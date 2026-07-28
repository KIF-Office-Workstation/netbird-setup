# NetBird Performance Benchmarks & Optimization Guide

This document details WireGuard performance metrics, MTU tuning, kernel vs userspace execution, and socket buffer optimizations for NetBird.

---

## 1. Throughput & Performance Metrics

| Connection Type | Protocol | Throughput (1Gbps Link) | Latency Overhead | CPU Usage |
| :--- | :--- | :--- | :--- | :--- |
| **Direct WireGuard P2P** | UDP (Kernel Module) | 880 - 950 Mbps | < 1 ms | Low (Kernel space) |
| **Embedded NetBird Relay** | WebSockets over HTTPS (443) | 450 - 680 Mbps | + 5 - 15 ms | Moderate |

---

## 2. MTU Optimization

The default interface MTU is set to `1280` bytes to prevent fragmentation over unknown WAN routes and IPsec/GRE tunnels.

To optimize MTU for high-speed fiber links with `1500` byte physical MTU:
```json
"MTU": 1420
```

---

## 3. Kernel Socket Buffer Tuning

Add the following settings to `/etc/sysctl.d/99-netbird-performance.conf`:
```ini
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.rmem_default = 262144
net.core.wmem_default = 262144
```
Apply settings:
```bash
sudo sysctl --system
```
