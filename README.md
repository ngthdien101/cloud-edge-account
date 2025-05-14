# cloud-edge-account
Multi-Account Edge Services Architecture with Centralized Transit Gateway Routing

## Architecture Pattern with Edge + Hub (TGW) + App Accounts
```
                          ┌─────────────────────────────┐
                          │        Internet             │
                          └────────────┬────────────────┘
                                       │
                      ┌────────────────────────────────────┐
                      │     Edge Services Account          │
                      │  - CloudFront                      │
                      │  - WAF                             │
                      │  - Route 53 (Public Hosted Zones)  │
                      │  - Redirect/Static Services (ALB)  │
                      └────────────────────────────────────┘
                                       │
                           (Private Integration via ALB/NLB)
                                       │
                      ┌────────────────────────────────────┐
                      │     Network Hub Account (TGW)       │
                      │  - Transit Gateway (TGW)            │
                      │  - Route tables per VPC segment     │
                      │  - Optional NAT Gateway / IGW       │
                      │  - Optional Network Firewall/IPS    │
                      └────────────────────────────────────┘
                                 ▲            ▲           ▲
        ┌────────────────────────┘            │           └────────────────────────┐
        │                                     │                                    │
┌────────────────────┐         ┌────────────────────┐              ┌────────────────────┐
│ Workload Account A │         │ Workload Account B │              │ Workload Account C │
│ - VPC-Attached     │         │ - VPC-Attached     │              │ - VPC-Attached     │
│ - ALB / ECS / EC2  │         │ - Lambda / Fargate │              │ - App-tier APIs    │
└────────────────────┘         └────────────────────┘              └────────────────────┘

                   ↖ All app VPCs are attached to TGW in the Network Hub Account ↗

```

| Component                 | Role                                                                                                                                                                             |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Edge Services Account** | Public entry point for internet traffic. Hosts CloudFront, WAF, ALBs for static sites or redirects, and public DNS. Does **not** hold private app logic.                         |
| **Network Hub Account**   | Centralized routing backbone. Hosts **Transit Gateway (TGW)** and optionally NAT, DNS forwarders, Network Firewall, etc. Responsible for connecting all VPCs across accounts.    |
| **App/Workload Accounts** | Business and technical workloads live here. Their VPCs are attached to TGW for east-west traffic and can expose internal services to the Edge account via private links or NLBs. |
| **Route 53**              | Public hosted zones in Edge; optionally private hosted zones in app accounts or shared services.                                                                                 |
## Security & Best Practice Notes
- [x] 🔐 Least privilege: App accounts only get access to specific route table entries in TGW, isolating east-west traffic.
- [x] 🔐 Service Discovery: Use Private Hosted Zones (PHZ) shared from Hub or central DNS.
- [x] 🔐 Logging: Flow logs and DNS query logs can be centralized in a Log Archive Account.
- [x] 🔐 Automation: Use AWS RAM and Infrastructure-as-Code to automate TGW VPC attachments and route propagation.
