if(BUILD_TESTS)
  add_subdirectory(test-input)

  if(OS_WINDOWS)
    add_subdirectory(win)
  endif()
endif()

if(ENABLE_UNIT_TESTS)
  add_subdirectory(cmocka)
endif()
