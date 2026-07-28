# NetBird Zero-Trust Security & Host Firewall Hardening Guide

This document outlines security hardening protocols, cryptographic standards, least privilege firewall rules, and secret isolation policies for NetBird.

---

## 1. Cryptographic Standards

- **Symmetric Cipher:** ChaCha20-Poly1305 for WireGuard payload encryption.
- **Key Exchange:** Curve25519 Elliptic-Curve Diffie-Hellman (ECDH).
- **Hashing:** BLAKE2s.
- **TLS Protocol:** TLS 1.2 / TLS 1.3 enforced by Traefik reverse proxy.

---

## 2. Least Privilege Firewall Configuration (UFW)

Only expose necessary public ingress ports. Internal gRPC ports (`10000`, `33073`) are proxied internally behind Traefik over HTTPS `443`.

Run the automated security script:
```bash
chmod +x ./docs/security/firewall_rules.sh
sudo ./docs/security/firewall_rules.sh
```

### Port Ingress Matrix
- `80/tcp`: HTTP ACME Challenge (Let's Encrypt)
- `443/tcp`: Unified HTTPS Endpoint (Dashboard, gRPC, API, Relay)
- `3478/udp`: NetBird STUN Service
- `51820/udp`: WireGuard P2P Overlay

---

## 3. Secret Isolation & Repository Hygiene

All configuration files in `config/` are sanitized templates using generic placeholders (`YOUR_SECRET_HERE`, `YOUR_SETUP_KEY`).
`.gitignore` strictly excludes real certificates (`*.pem`, `*.key`), database files (`*.db`), `.env` files, and backup archives.
