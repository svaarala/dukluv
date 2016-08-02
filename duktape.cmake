set(DUKTAPEDIR ${CMAKE_CURRENT_LIST_DIR}/lib/duktape)

if(EXISTS ${DUKTAPEDIR}/extras/logging/duk_logging.c)
# Duktape 2.x: assume both logging provider and duk-v1-compat exists.
# The duk-v1-compat transition helpers are needed for duk_put_function_list().
include_directories(
  ${DUKTAPEDIR}/src
  ${DUKTAPEDIR}/extras/logging
  ${DUKTAPEDIR}/extras/duk-v1-compat
)
add_library(duktape STATIC
  ${DUKTAPEDIR}/src/duktape.c
  ${DUKTAPEDIR}/extras/logging/duk_logging.c
  ${DUKTAPEDIR}/extras/duk-v1-compat/duk_v1_compat.c
)
else()
include_directories(
  ${DUKTAPEDIR}/src
)
add_library(duktape STATIC
  ${DUKTAPEDIR}/src/duktape.c
)
endif()

if("${CMAKE_SYSTEM_NAME}" MATCHES "Linux")
  target_link_libraries(duktape
    m dl rt
  )
endif()
