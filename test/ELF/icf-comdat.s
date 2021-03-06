# REQUIRES: x86

# RUN: llvm-mc -filetype=obj -triple=x86_64-unknown-linux %s -o %t
# RUN: ld.lld %t -o %t2 --icf=all --print-icf-sections | FileCheck %s

# CHECK: selected section '.text.f1' from file [[T:'.*']]
# CHECK:   removing identical section '.text.f2' from file [[T]]

.globl _start, f1, f2
_start:
  ret

.section .text.f1,"ax"
f1:
  mov $60, %rax
  mov $42, %rdi
  syscall

.section .text.f2,"axG",@progbits,foo,comdat
f2:
  mov $60, %rax
  mov $42, %rdi
  syscall
