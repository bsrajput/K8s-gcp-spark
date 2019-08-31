locals = {
  cluster_name = "dois2019.engineerto.be"
  project      = "dois2019"
  region       = "us-east1"
}

output "cluster_name" {
  value = "dois2019.engineerto.be"
}

output "project" {
  value = "dois2019"
}

output "region" {
  value = "us-east1"
}

provider "google" {
  project = "dois2019"
  region  = "us-east1"
}

resource "google_compute_disk" "b-etcd-events-dois2019-engineerto-be" {
  name = "b-etcd-events-dois2019-engineerto-be"
  type = "pd-ssd"
  size = 20
  zone = "us-east1-b"

  labels = {
    k8s-io-cluster-name = "dois2019-engineerto-be"
    k8s-io-etcd-events  = "b-2fb"
    k8s-io-role-master  = "master"
  }
}

resource "google_compute_disk" "b-etcd-main-dois2019-engineerto-be" {
  name = "b-etcd-main-dois2019-engineerto-be"
  type = "pd-ssd"
  size = 20
  zone = "us-east1-b"

  labels = {
    k8s-io-cluster-name = "dois2019-engineerto-be"
    k8s-io-etcd-main    = "b-2fb"
    k8s-io-role-master  = "master"
  }
}

resource "google_compute_firewall" "cidr-to-master-dois2019-engineerto-be" {
  name    = "cidr-to-master-dois2019-engineerto-be"
  network = "${google_compute_network.default.name}"

  allow = {
    protocol = "tcp"
    ports    = ["443"]
  }

  allow = {
    protocol = "tcp"
    ports    = ["4194"]
  }

  source_ranges = ["100.64.0.0/10"]
  target_tags   = ["dois2019-engineerto-be-k8s-io-role-master"]
}

resource "google_compute_firewall" "cidr-to-node-dois2019-engineerto-be" {
  name    = "cidr-to-node-dois2019-engineerto-be"
  network = "${google_compute_network.default.name}"

  allow = {
    protocol = "tcp"
  }

  allow = {
    protocol = "udp"
  }

  allow = {
    protocol = "icmp"
  }

  allow = {
    protocol = "esp"
  }

  allow = {
    protocol = "ah"
  }

  allow = {
    protocol = "sctp"
  }

  source_ranges = ["100.64.0.0/10"]
  target_tags   = ["dois2019-engineerto-be-k8s-io-role-node"]
}

resource "google_compute_firewall" "kubernetes-master-https-dois2019-engineerto-be" {
  name    = "kubernetes-master-https-dois2019-engineerto-be"
  network = "${google_compute_network.default.name}"

  allow = {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["dois2019-engineerto-be-k8s-io-role-master"]
}

resource "google_compute_firewall" "master-to-master-dois2019-engineerto-be" {
  name    = "master-to-master-dois2019-engineerto-be"
  network = "${google_compute_network.default.name}"

  allow = {
    protocol = "tcp"
  }

  allow = {
    protocol = "udp"
  }

  allow = {
    protocol = "icmp"
  }

  allow = {
    protocol = "esp"
  }

  allow = {
    protocol = "ah"
  }

  allow = {
    protocol = "sctp"
  }

  source_tags = ["dois2019-engineerto-be-k8s-io-role-master"]
  target_tags = ["dois2019-engineerto-be-k8s-io-role-master"]
}

resource "google_compute_firewall" "master-to-node-dois2019-engineerto-be" {
  name    = "master-to-node-dois2019-engineerto-be"
  network = "${google_compute_network.default.name}"

  allow = {
    protocol = "tcp"
  }

  allow = {
    protocol = "udp"
  }

  allow = {
    protocol = "icmp"
  }

  allow = {
    protocol = "esp"
  }

  allow = {
    protocol = "ah"
  }

  allow = {
    protocol = "sctp"
  }

  source_tags = ["dois2019-engineerto-be-k8s-io-role-master"]
  target_tags = ["dois2019-engineerto-be-k8s-io-role-node"]
}

resource "google_compute_firewall" "node-to-master-dois2019-engineerto-be" {
  name    = "node-to-master-dois2019-engineerto-be"
  network = "${google_compute_network.default.name}"

  allow = {
    protocol = "tcp"
    ports    = ["443"]
  }

  allow = {
    protocol = "tcp"
    ports    = ["4194"]
  }

  source_tags = ["dois2019-engineerto-be-k8s-io-role-node"]
  target_tags = ["dois2019-engineerto-be-k8s-io-role-master"]
}

resource "google_compute_firewall" "node-to-node-dois2019-engineerto-be" {
  name    = "node-to-node-dois2019-engineerto-be"
  network = "${google_compute_network.default.name}"

  allow = {
    protocol = "tcp"
  }

  allow = {
    protocol = "udp"
  }

  allow = {
    protocol = "icmp"
  }

  allow = {
    protocol = "esp"
  }

  allow = {
    protocol = "ah"
  }

  allow = {
    protocol = "sctp"
  }

  source_tags = ["dois2019-engineerto-be-k8s-io-role-node"]
  target_tags = ["dois2019-engineerto-be-k8s-io-role-node"]
}

resource "google_compute_firewall" "nodeport-external-to-node-dois2019-engineerto-be" {
  name    = "nodeport-external-to-node-dois2019-engineerto-be"
  network = "${google_compute_network.default.name}"

  allow = {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  allow = {
    protocol = "udp"
    ports    = ["30000-32767"]
  }

  source_tags = ["dois2019-engineerto-be-k8s-io-role-node"]
  target_tags = ["dois2019-engineerto-be-k8s-io-role-node"]
}

resource "google_compute_firewall" "ssh-external-to-master-dois2019-engineerto-be" {
  name    = "ssh-external-to-master-dois2019-engineerto-be"
  network = "${google_compute_network.default.name}"

  allow = {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["dois2019-engineerto-be-k8s-io-role-master"]
}

resource "google_compute_firewall" "ssh-external-to-node-dois2019-engineerto-be" {
  name    = "ssh-external-to-node-dois2019-engineerto-be"
  network = "${google_compute_network.default.name}"

  allow = {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["dois2019-engineerto-be-k8s-io-role-node"]
}

resource "google_compute_instance_group_manager" "b-master-us-east1-b-dois2019-engineerto-be" {
  name               = "b-master-us-east1-b-dois2019-engineerto-be"
  zone               = "us-east1-b"
  base_instance_name = "master-us-east1-b"
  instance_template  = "${google_compute_instance_template.master-us-east1-b-dois2019-engineerto-be.self_link}"
  target_size        = 1
}

resource "google_compute_instance_group_manager" "b-nodes-dois2019-engineerto-be" {
  name               = "b-nodes-dois2019-engineerto-be"
  zone               = "us-east1-b"
  base_instance_name = "nodes"
  instance_template  = "${google_compute_instance_template.nodes-dois2019-engineerto-be.self_link}"
  target_size        = 2
}

resource "google_compute_instance_template" "master-us-east1-b-dois2019-engineerto-be" {
  can_ip_forward = true
  machine_type   = "n1-standard-4"

  service_account = {
    scopes = ["https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/devstorage.read_write", "https://www.googleapis.com/auth/ndev.clouddns.readwrite"]
  }

  scheduling = {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }

  disk = {
    auto_delete  = true
    device_name  = "persistent-disks-0"
    type         = "PERSISTENT"
    boot         = true
    source_image = "https://www.googleapis.com/compute/v1/projects/cos-cloud/global/images/cos-stable-65-10323-99-0"
    mode         = "READ_WRITE"
    disk_type    = "pd-standard"
    disk_size_gb = 64
  }

  network_interface = {
    network       = "${google_compute_network.default.name}"
    access_config = {}
  }

  metadata = {
    cluster-name   = "${file("${path.module}/data/google_compute_instance_template_master-us-east1-b-dois2019-engineerto-be_metadata_cluster-name")}"
    ssh-keys       = "${file("${path.module}/data/google_compute_instance_template_master-us-east1-b-dois2019-engineerto-be_metadata_ssh-keys")}"
    startup-script = "${file("${path.module}/data/google_compute_instance_template_master-us-east1-b-dois2019-engineerto-be_metadata_startup-script")}"
  }

  tags        = ["dois2019-engineerto-be-k8s-io-role-master"]
  name_prefix = "master-us-east1-b-dois2019-engineerto-be-"
}

resource "google_compute_instance_template" "nodes-dois2019-engineerto-be" {
  can_ip_forward = true
  machine_type   = "n1-standard-2"

  service_account = {
    scopes = ["https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/devstorage.read_only"]
  }

  scheduling = {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }

  disk = {
    auto_delete  = true
    device_name  = "persistent-disks-0"
    type         = "PERSISTENT"
    boot         = true
    source_image = "https://www.googleapis.com/compute/v1/projects/cos-cloud/global/images/cos-stable-65-10323-99-0"
    mode         = "READ_WRITE"
    disk_type    = "pd-standard"
    disk_size_gb = 128
  }

  network_interface = {
    network       = "${google_compute_network.default.name}"
    access_config = {}
  }

  metadata = {
    cluster-name   = "${file("${path.module}/data/google_compute_instance_template_nodes-dois2019-engineerto-be_metadata_cluster-name")}"
    ssh-keys       = "${file("${path.module}/data/google_compute_instance_template_nodes-dois2019-engineerto-be_metadata_ssh-keys")}"
    startup-script = "${file("${path.module}/data/google_compute_instance_template_nodes-dois2019-engineerto-be_metadata_startup-script")}"
  }

  tags        = ["dois2019-engineerto-be-k8s-io-role-node"]
  name_prefix = "nodes-dois2019-engineerto-be-"
}

resource "google_compute_network" "default" {
  name                    = "default"
  auto_create_subnetworks = true
}

resource "google_storage_bucket_acl" "serviceaccount-backup-readwrite-dois2019-k8s-state" {
  bucket      = "dois2019-k8s-state"
  role_entity = ["WRITER:serviceaccount-backup-readwrite-dois2019-k8s-state"]
}

terraform = {
  required_version = ">= 0.9.3"
}
