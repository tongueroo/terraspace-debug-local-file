resource "random_pet" "this" {
  length = 2
}

module "bucket" {
  source     = "../../modules/example"
  bucket     = "bucket-${random_pet.this.id}"
  acl        = var.acl
}

resource "local_file" "foo2" {
  content     = "foo2!"
  filename = "${path.module}/foo2.txt"
}
