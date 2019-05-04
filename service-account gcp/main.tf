provider "google" {
  credentials   = "${file("${var.cpath}")}"   #GOOGLE_CREDENTIALS to the path of a file containing the credential JSON
  project       = "${var.project}"
}
resource "google_service_account" "sonick" {
    account_id   = "${var.account_id}"
    display_name = "${var.display_name}"
}

resource "google_service_account_key" "mykey" {
  depends_on          = ["google_service_account.sonick"]
  service_account_id  = "${google_service_account.sonick.name}"
  public_key_type     = "TYPE_X509_PEM_FILE"
#   valid_after         = "2014-10-02T15:01:23.045123456Z"  (The key can be used after this timestamp. A timestamp in RFC3339 UTC "Zulu" format, accurate to nanoseconds.)
#   valid_before        = "2014-10-02T15:01:23.045123456Z"  (The key can be used before this timestamp. A timestamp in RFC3339 UTC "Zulu" format, accurate to nanoseconds.) 
}

resource "google_project_iam_member" "sstanytska" {
    depends_on        = ["google_service_account.sonick"]
    count             =  "${length(var.roles)}"
    role              =  "${element(var.roles, count.index)}"
    member            =  "serviceAccount:${google_service_account.sonick.email}"
}

resource "local_file" "privateKey" {
    content     = "${base64decode(google_service_account_key.mykey.private_key)}"
    filename    = "tmp/private_key.json"
}