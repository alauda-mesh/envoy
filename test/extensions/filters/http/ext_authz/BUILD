load(
    "//bazel:envoy_build_system.bzl",
    "envoy_cc_fuzz_test",
    "envoy_cc_test_library",
    "envoy_package",
    "envoy_proto_library",
)
load(
    "//test/extensions:extensions_build_system.bzl",
    "envoy_extension_cc_test",
    "envoy_extension_cc_test_library",
)

licenses(["notice"])  # Apache 2

envoy_package()

envoy_extension_cc_test(
    name = "ext_authz_test",
    srcs = ["ext_authz_test.cc"],
    extension_names = ["envoy.filters.http.ext_authz"],
    rbe_pool = "6gig",
    deps = [
        "//envoy/http:codes_interface",
        "//source/common/buffer:buffer_lib",
        "//source/common/common:empty_string",
        "//source/common/http:context_lib",
        "//source/common/http:headers_lib",
        "//source/common/json:json_loader_lib",
        "//source/common/network:address_lib",
        "//source/common/protobuf:utility_lib",
        "//source/extensions/filters/common/ext_authz:ext_authz_grpc_lib",
        "//source/extensions/filters/http/ext_authz",
        "//test/extensions/filters/common/ext_authz:ext_authz_mocks",
        "//test/mocks/http:http_mocks",
        "//test/mocks/network:network_mocks",
        "//test/mocks/runtime:runtime_mocks",
        "//test/mocks/server:server_factory_context_mocks",
        "//test/mocks/tracing:tracing_mocks",
        "//test/mocks/upstream:cluster_manager_mocks",
        "//test/proto:helloworld_proto_cc_proto",
        "//test/test_common:test_runtime_lib",
        "//test/test_common:utility_lib",
        "@envoy_api//envoy/config/core/v3:pkg_cc_proto",
        "@envoy_api//envoy/extensions/filters/http/ext_authz/v3:pkg_cc_proto",
        "@envoy_api//envoy/service/auth/v3:pkg_cc_proto",
        "@envoy_api//envoy/type/v3:pkg_cc_proto",
    ],
)

envoy_extension_cc_test(
    name = "config_test",
    srcs = ["config_test.cc"],
    extension_names = ["envoy.filters.http.ext_authz"],
    rbe_pool = "6gig",
    deps = [
        "//source/common/grpc:async_client_manager_lib",
        "//source/common/network:address_lib",
        "//source/common/thread_local:thread_local_lib",
        "//source/extensions/filters/http/ext_authz:config",
        "//test/mocks/server:factory_context_mocks",
        "//test/test_common:real_threads_test_helper_lib",
        "//test/test_common:test_runtime_lib",
        "@envoy_api//envoy/config/bootstrap/v3:pkg_cc_proto",
        "@envoy_api//envoy/config/core/v3:pkg_cc_proto",
        "@envoy_api//envoy/extensions/filters/http/ext_authz/v3:pkg_cc_proto",
    ],
)

envoy_extension_cc_test(
    name = "ext_authz_integration_test",
    size = "large",
    srcs = ["ext_authz_integration_test.cc"],
    data = [
        "ext_authz.yaml",
    ],
    extension_names = ["envoy.filters.http.ext_authz"],
    rbe_pool = "6gig",
    deps = [
        ":ext_authz_fuzz_proto_cc_proto",
        ":logging_test_filter_lib",
        "//source/extensions/clusters/strict_dns:strict_dns_cluster_lib",
        "//source/extensions/filters/http/ext_authz:config",
        "//source/extensions/listener_managers/validation_listener_manager:validation_listener_manager_lib",
        "//source/server/config_validation:server_lib",
        "//test/integration:http_integration_lib",
        "//test/mocks/server:options_mocks",
        "//test/test_common:test_runtime_lib",
        "//test/test_common:utility_lib",
        "@envoy_api//envoy/config/bootstrap/v3:pkg_cc_proto",
        "@envoy_api//envoy/config/listener/v3:pkg_cc_proto",
        "@envoy_api//envoy/extensions/filters/http/ext_authz/v3:pkg_cc_proto",
        "@envoy_api//envoy/service/auth/v3:pkg_cc_proto",
    ],
)

envoy_proto_library(
    name = "ext_authz_fuzz_proto",
    srcs = ["ext_authz_fuzz.proto"],
    deps = [
        "//test/fuzz:common_proto",
        "@envoy_api//envoy/config/core/v3:pkg",
        "@envoy_api//envoy/extensions/filters/http/ext_authz/v3:pkg",
        "@envoy_api//envoy/service/auth/v3:pkg",
    ],
)

envoy_cc_fuzz_test(
    name = "ext_authz_grpc_fuzz_test",
    srcs = ["ext_authz_grpc_fuzz_test.cc"],
    corpus = "ext_authz_grpc_corpus",
    rbe_pool = "6gig",
    deps = [
        ":ext_authz_fuzz_lib",
        ":ext_authz_fuzz_proto_cc_proto",
        "//source/common/common:assert_lib",
        "//source/extensions/filters/common/ext_authz:ext_authz_grpc_lib",
        "//test/extensions/filters/common/ext_authz:ext_authz_test_common",
        "//test/extensions/filters/http/common/fuzz:http_filter_fuzzer_lib",
        "//test/mocks/grpc:grpc_mocks",
        "@envoy_api//envoy/extensions/filters/http/ext_authz/v3:pkg_cc_proto",
        "@envoy_api//envoy/service/auth/v3:pkg_cc_proto",
    ],
)

envoy_cc_fuzz_test(
    name = "ext_authz_http_fuzz_test",
    srcs = ["ext_authz_http_fuzz_test.cc"],
    corpus = "ext_authz_http_corpus",
    rbe_pool = "6gig",
    deps = [
        ":ext_authz_fuzz_lib",
        ":ext_authz_fuzz_proto_cc_proto",
        "//source/common/common:assert_lib",
        "//source/extensions/filters/common/ext_authz:ext_authz_http_lib",
        "//test/extensions/filters/common/ext_authz:ext_authz_test_common",
        "//test/extensions/filters/http/common/fuzz:http_filter_fuzzer_lib",
        "//test/mocks/network:network_mocks",
        "//test/mocks/server:server_factory_context_mocks",
        "//test/mocks/upstream:cluster_manager_mocks",
        "@envoy_api//envoy/extensions/filters/http/ext_authz/v3:pkg_cc_proto",
        "@envoy_api//envoy/service/auth/v3:pkg_cc_proto",
    ],
)

envoy_cc_test_library(
    name = "ext_authz_fuzz_lib",
    srcs = ["ext_authz_fuzz_lib.cc"],
    hdrs = ["ext_authz_fuzz_lib.h"],
    rbe_pool = "6gig",
    deps = [
        ":ext_authz_fuzz_proto_cc_proto",
        "//source/common/http:context_lib",
        "//source/common/network:address_lib",
        "//source/extensions/filters/http/ext_authz",
        "//test/mocks/network:network_mocks",
        "//test/mocks/server:server_factory_context_mocks",
        "@envoy_api//envoy/config/core/v3:pkg_cc_proto",
    ],
)

envoy_proto_library(
    name = "logging_test_filter_proto",
    srcs = ["logging_test_filter.proto"],
)

envoy_extension_cc_test_library(
    name = "logging_test_filter_lib",
    srcs = [
        "logging_test_filter.cc",
    ],
    extension_names = ["envoy.filters.http.ext_authz"],
    deps = [
        ":logging_test_filter_proto_cc_proto",
        "//envoy/http:filter_interface",
        "//envoy/registry",
        "//envoy/server:filter_config_interface",
        "//source/common/router:string_accessor_lib",
        "//source/extensions/filters/http/common:factory_base_lib",
        "//source/extensions/filters/http/common:pass_through_filter_lib",
        "//source/extensions/filters/http/ext_authz",
        "//test/test_common:utility_lib",
    ],
)
