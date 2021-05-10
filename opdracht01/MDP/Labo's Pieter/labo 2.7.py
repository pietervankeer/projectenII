from ncclient import manager

m = manager.connect(
    host = "192.168.56.104",
    port="830",
    username="cisco",
    password="cisco123!",
    hostkey_verify=False    
    )

print("#Supported Capabilities (YANG models):")
for capability in m.server_capabilities:
        print(capability)
