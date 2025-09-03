# On-Premise Kubernetes ➜ OpenShift Migration (Kubernetes + OpenShift)

This repository demonstrates a professional **end-to-end migration** of workloads from a vanilla **Kubernetes on Linux** environment to **OpenShift 4.x**, with a focus on **security hardening** and **resource optimization**.

---

## 🚀 Project Overview

* **Migrated 15+ workloads** from on-prem Kubernetes clusters to OpenShift.
* Hardened runtime security using **SCCs**, **OPA Gatekeeper policies**, and **image registry allowlisting**.
* Optimized cluster resource usage with **requests/limits**, **ResourceQuotas**, **LimitRanges**, and **autoscaling (HPA + Cluster Autoscaler)**.
* Delivered repeatable and auditable manifests for a reliable enterprise-grade migration.

---

## 📂 Repository Structure

```
openshift-migration/
├─ inventory/          # Discovery and audit scripts/findings
├─ platform/           # OpenShift platform configuration (SCCs, quotas, autoscaling)
├─ workloads/          # Example workloads (Kustomize overlays for Kubernetes → OpenShift)
├─ tools/              # Migration helper scripts (image mirror, validation)
└─ README.md           # Project documentation
```

---

## 🛠️ Features

* **Discovery & Assessment**: Audit existing Kubernetes workloads (deployments, ingress, PVCs, images).
* **Platform Setup**: Namespaces, quotas, SCC role bindings, and OpenShift-native security.
* **Workload Migration**: Kustomize-based manifests adapted for OpenShift (`Ingress → Route`, `Docker image → ImageStream`).
* **Security Hardening**: Enforce non-root, disallow privilege escalation, and limit registries.
* **Autoscaling**: Pod-level scaling with HPA, and node-level scaling with Cluster/Machine Autoscaler.
* **Validation Tools**: Scripts for rollout verification and endpoint testing.

---

## 📋 Migration Steps

1. **Inventory current workloads**

   ```bash
   ./inventory/audit.sh
   ```

2. **Prepare OpenShift projects, quotas, and SCCs**

   ```bash
   oc create -f platform/namespaces/team-a.yaml
   oc apply -f platform/quotas/
   oc apply -f platform/security/
   ```

3. **Mirror application images to OpenShift registry**

   ```bash
   ./tools/image-mirror.sh docker.io/library/nginx:1.25 team-a sample-app
   ```

4. **Deploy workloads with OpenShift overlays**

   ```bash
   oc project team-a
   oc apply -k workloads/sample-app/overlays/openshift
   ```

5. **Validate deployment**

   ```bash
   ./tools/validate.sh team-a sample-app
   ```

---

## 🔐 Security Controls

* **SCCs**: Default workloads bound to `restricted-v2` SCC.
* **OPA Gatekeeper**: Admission policies for required labels, image registry allowlisting, and non-root enforcement.
* **Cluster Image Policy**: Restricts imports to approved registries.

---

## ⚡ Autoscaling

* **HPA**: Ensures pods scale based on CPU utilization.
* **Cluster Autoscaler**: Dynamically scales cluster nodes.
* **Machine Autoscaler**: Scales MachineSets for node pools.

---

## ✅ Validation Checklist

* [ ] All pods deployed successfully
* [ ] Routes accessible via HTTPS
* [ ] Security policies enforced (non-root, registry allowlisting)
* [ ] HPA triggers under CPU load
* [ ] Resource quotas applied correctly

---

## 📊 Outcomes

* **Security**: Improved governance with enforced policies.
* **Reliability**: Standardized manifests, faster deployments.
* **Efficiency**: Reduced over-provisioning via autoscaling.

---

## 📚 Enhancements (Future Work)

* Image signing with **cosign** and enforcement.
* Automated backup/restore with **Velero**.
* Service Mesh integration for advanced traffic management.
* CI/CD pipelines with **Tekton** for build and deploy.

---

## 💼 Resume-Ready Highlights

* Migrated **15+ workloads** from Kubernetes to OpenShift with minimal downtime.
* Implemented **Gatekeeper** policies and **SCC-based** security hardening.
* Optimized workload efficiency with **autoscaling** and enforced **resource governance**.

---

## 🧑‍💻 Quick Demo (5–10 minutes)

1. Create project and apply quotas.
2. Mirror an image into OpenShift.
3. Deploy a sample workload overlay.
4. Show Gatekeeper blocking a non-compliant pod.
5. Trigger HPA scaling with load test.
6. Access the app via OpenShift Route.

---

### 📌 Author

**Olabowale Babatunde Ipaye**
Backend/DevOps Engineer (Kubernetes | OpenShift | Cloud)
[LinkedIn](https://linkedin.com/in/engripayebabatunde) • [GitHub](https://github.com/engripaye)

---

This repository is designed for both **professional demonstrations** and **real-world migrations**, providing a clear, reproducible migration path from Kubernetes to OpenShift.
