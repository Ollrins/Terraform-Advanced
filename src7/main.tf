provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "education"
}

data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data)
}



##

resource "vault_generic_secret" "vs" {
  path = "secret/my-vs"
  
  data_json = jsonencode({
    username = "ollrins"
    password = "If you never try, you will never know"
    api_key  = "1579751"
    created_by = "terraform"
    created_at = timestamp()
  })
}

##

data "vault_generic_secret" "read_vs" {
  path = vault_generic_secret.vs.path
  depends_on = [vault_generic_secret.vs]
}

output "vs_data" {
  value = nonsensitive(data.vault_generic_secret.read_vs.data)
  description = "Context"
}

output "vs_path" {
  value = vault_generic_secret.vs.path
  description = "Path..."
}
