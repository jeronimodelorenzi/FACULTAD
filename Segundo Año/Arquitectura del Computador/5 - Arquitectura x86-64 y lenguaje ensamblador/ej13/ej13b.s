/*
unsigned long fact1(unsigned long x){
  if(x<=1){
    return x;
  }
  return x * fact1(x-1);
}
*/

.globl fact1

# FORMA 1

fact1:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp

    cmpq $1, %rdi
    jg recursion
    movq $1, %rax
    jmp fin_fact1

recursion:
    pushq %rdi
    decq %rdi
    call fact1
    popq %rdi
    imulq %rdi

fin_fact1:
    # epílogo
    movq %rbp, %rsp
    popq %rbp
    ret

