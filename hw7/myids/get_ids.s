    .globl get_ids
get_ids:
	pushl  %ebp           #Push old base pointer
	movl   %esp, %ebp     #Put user id stack pointer into base pointer
	movl   8(%ebp), %ecx  #Move pointer to user id to %ecx
	movl   $24, %eax      #Move getuid number into %eax
	int    $0x80          #Invoke intentional trap call
	mov    %eax, (%ecx)   #Move result into value pointed by stack pointer
	mov    12(%ebp), %ecx #Move group id stack pointer into base pointer
	mov    $47, %eax      #Move getgid number into %eax
	int    $0x80          #Invoke intentional trap call
	mov    %eax, (%ecx)   #Move result into value pointed by stack pointer
	pop    %ebp           #Restore base pointer
	ret
