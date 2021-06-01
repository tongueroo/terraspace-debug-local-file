resource "random_pet" "this" {
  length = 2
}

module "bucket" {
  source     = "../../modules/example"
  bucket     = "bucket-${random_pet.this.id}"
  acl        = var.acl
}

resource "local_file" "foo1" {
  content     = "foo1"
  filename = "${path.module}/foo1.txt"
}
