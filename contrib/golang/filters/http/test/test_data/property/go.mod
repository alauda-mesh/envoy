module example.com/property

go 1.23

require (
	github.com/envoyproxy/envoy v1.24.0
	google.golang.org/protobuf v1.36.10
)

replace github.com/envoyproxy/envoy => ../../../../../../../
