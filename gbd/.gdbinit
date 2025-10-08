
# Regex-based function rules
## Skip namespaces / functions (C++)
skip -rfu ^std::
skip -rfu ^__gnu_cxx::
skip -rfu ^__cxxabiv1::

## Common C libc you might not want to enter
skip -rfu ^malloc$
skip -rfu ^free$
skip -rfu ^printf$

## Skip whole files or paths (headers, libs)
# Glob-based file rules
skip -gfi /usr/include/**
skip -gfi /usr/lib/**/libstdc++*

# Skip only gtest framework itself
skip -gfi */gtest/*
skip -gfi */gmock/*

# Add function regex rules for gTest:
skip -rfu ^testing::
skip -rfu ^testing::internal::
# (Optional, sometimes names come through with a leading ::)
skip -rfu ^::testing::
