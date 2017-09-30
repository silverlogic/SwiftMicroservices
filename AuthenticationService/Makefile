
# ================================
# Server (Microservice) Container
# ================================
build_server:
	swift build

start_server:
	./.build/debug/AuthenticationService

# ================================
# Full Environment
# ================================
start_env: build_server start_server
