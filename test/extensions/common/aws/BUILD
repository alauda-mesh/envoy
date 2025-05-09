load(
    "//bazel:envoy_build_system.bzl",
    "envoy_cc_mock",
    "envoy_cc_test",
    "envoy_package",
    "envoy_select_boringssl",
)

licenses(["notice"])  # Apache 2

envoy_package()

envoy_cc_mock(
    name = "aws_mocks",
    srcs = ["mocks.cc"],
    hdrs = ["mocks.h"],
    rbe_pool = "6gig",
    deps = [
        "//source/common/http:message_lib",
        "//source/extensions/common/aws:credentials_provider_interface",
        "//source/extensions/common/aws:metadata_fetcher_lib",
        "//source/extensions/common/aws:signer_interface",
        "//test/mocks/upstream:cluster_manager_mocks",
    ],
)

envoy_cc_test(
    name = "sigv4_signer_impl_test",
    srcs = ["sigv4_signer_impl_test.cc"],
    rbe_pool = "6gig",
    deps = [
        "//source/common/buffer:buffer_lib",
        "//source/common/http:message_lib",
        "//source/extensions/common/aws:sigv4_signer_impl_lib",
        "//test/extensions/common/aws:aws_mocks",
        "//test/mocks/server:server_factory_context_mocks",
        "//test/test_common:simulated_time_system_lib",
        "//test/test_common:utility_lib",
    ],
)

envoy_cc_test(
    name = "sigv4_signer_corpus_test",
    srcs = ["sigv4_signer_corpus_test.cc"],
    data = ["@com_github_awslabs_aws_c_auth//:sigv4_tests"],
    rbe_pool = "6gig",
    deps = [
        "//source/common/buffer:buffer_lib",
        "//source/common/http:message_lib",
        "//source/extensions/common/aws:sigv4_signer_impl_lib",
        "//test/extensions/common/aws:aws_mocks",
        "//test/mocks/server:server_factory_context_mocks",
        "//test/test_common:simulated_time_system_lib",
        "//test/test_common:utility_lib",
    ],
)

envoy_cc_test(
    name = "sigv4a_signer_corpus_test",
    srcs = ["sigv4a_signer_corpus_test.cc"],
    data = ["@com_github_awslabs_aws_c_auth//:sigv4a_tests"],
    rbe_pool = "4core",
    deps = [
        "//source/common/buffer:buffer_lib",
        "//source/common/http:message_lib",
        "//source/extensions/common/aws:sigv4a_signer_impl_lib",
        "//test/extensions/common/aws:aws_mocks",
        "//test/mocks/server:server_factory_context_mocks",
        "//test/test_common:simulated_time_system_lib",
        "//test/test_common:utility_lib",
    ],
)

envoy_cc_test(
    name = "sigv4a_signer_impl_test",
    srcs = ["sigv4a_signer_impl_test.cc"],
    rbe_pool = "6gig",
    deps = [
        "//source/common/buffer:buffer_lib",
        "//source/common/http:message_lib",
        "//source/extensions/common/aws:sigv4a_key_derivation_lib",
        "//source/extensions/common/aws:sigv4a_signer_impl_lib",
        "//test/extensions/common/aws:aws_mocks",
        "//test/mocks/server:server_factory_context_mocks",
        "//test/test_common:simulated_time_system_lib",
        "//test/test_common:utility_lib",
    ],
)

envoy_cc_test(
    name = "utility_test",
    srcs = ["utility_test.cc"],
    copts = envoy_select_boringssl(
        [
            "-DENVOY_SSL_FIPS",
        ],
    ),
    rbe_pool = "6gig",
    deps = [
        "//source/extensions/common/aws:utility_lib",
        "//test/extensions/common/aws:aws_mocks",
        "//test/mocks/server:server_factory_context_mocks",
        "//test/test_common:utility_lib",
    ],
)

envoy_cc_test(
    name = "region_provider_impl_test",
    srcs = ["region_provider_impl_test.cc"],
    rbe_pool = "6gig",
    deps = [
        "//source/extensions/common/aws:region_provider_impl_lib",
        "//test/test_common:environment_lib",
    ],
)

envoy_cc_test(
    name = "metadata_fetcher_test",
    srcs = ["metadata_fetcher_test.cc"],
    rbe_pool = "6gig",
    deps = [
        "//source/extensions/common/aws:metadata_fetcher_lib",
        "//test/extensions/common/aws:aws_mocks",
        "//test/extensions/filters/http/common:mock_lib",
        "//test/mocks/api:api_mocks",
        "//test/mocks/event:event_mocks",
        "//test/mocks/server:factory_context_mocks",
        "//test/test_common:environment_lib",
        "//test/test_common:simulated_time_system_lib",
        "//test/test_common:utility_lib",
    ],
)

envoy_cc_test(
    name = "credentials_provider_impl_test",
    srcs = ["credentials_provider_impl_test.cc"],
    rbe_pool = "6gig",
    deps = [
        "//source/extensions/common/aws:credentials_provider_impl_lib",
        "//source/extensions/common/aws:metadata_fetcher_lib",
        "//test/extensions/common/aws:aws_mocks",
        "//test/mocks/api:api_mocks",
        "//test/mocks/event:event_mocks",
        "//test/mocks/runtime:runtime_mocks",
        "//test/mocks/server:factory_context_mocks",
        "//test/mocks/server:listener_factory_context_mocks",
        "//test/mocks/upstream:cluster_manager_mocks",
        "//test/mocks/upstream:cluster_update_callbacks_handle_mocks",
        "//test/mocks/upstream:cluster_update_callbacks_mocks",
        "//test/mocks/upstream:host_mocks",
        "//test/mocks/upstream:thread_local_cluster_mocks",
        "//test/test_common:environment_lib",
        "//test/test_common:simulated_time_system_lib",
        "//test/test_common:test_runtime_lib",
    ],
)

envoy_cc_test(
    name = "credentials_provider_test",
    srcs = ["credentials_provider_test.cc"],
    rbe_pool = "6gig",
    deps = [
        "//source/extensions/common/aws:credentials_provider_interface",
    ],
)

envoy_cc_test(
    name = "aws_metadata_fetcher_integration_test",
    size = "large",
    srcs = [
        "aws_metadata_fetcher_integration_test.cc",
    ],
    rbe_pool = "6gig",
    deps = [
        "//source/common/common:fmt_lib",
        "//source/extensions/common/aws:utility_lib",
        "//source/extensions/filters/http/fault:config",
        "//source/extensions/filters/http/fault:fault_filter_lib",
        "//source/extensions/filters/http/router:config",
        "//source/extensions/filters/network/echo:config",
        "//source/extensions/filters/network/http_connection_manager:config",
        "//test/integration:integration_lib",
        "//test/server:utility_lib",
        "//test/test_common:utility_lib",
    ],
)
