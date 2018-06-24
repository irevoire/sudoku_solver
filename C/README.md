C sudoku
========

Some optimization I tried
-------------------------

![A callgrind view of the execution](img/no_opt.png)

We can see most of the time is lost in the function _include_ wich calculate the hash to access all the element in the grid and check if they already exists on the current column / line / bloc.

At the time I wrote theses lines the code of *HASH\_BLOC* look like this :

```C
static inline int HASH_BLOC(int x, int y, int n)
{
	const int xp = (x / 3 * 3 + n / 3) * 10;
	const int yp = y / 3 * 3 + n % 3;

	return xp + yp;
}
```

Which generate this assembly code (by compiling with clang in O0) :

```assembly
_HASH_BLOC:
     330:       55      pushq   %rbp
     331:       48 89 e5        movq    %rsp, %rbp
     334:       b8 03 00 00 00  movl    $3, %eax
     339:       89 7d fc        movl    %edi, -4(%rbp)
     33c:       89 75 f8        movl    %esi, -8(%rbp)
     33f:       89 55 f4        movl    %edx, -12(%rbp)
     342:       8b 55 fc        movl    -4(%rbp), %edx
     345:       89 45 e8        movl    %eax, -24(%rbp)
     348:       89 d0   movl    %edx, %eax
     34a:       99      cltd
     34b:       8b 75 e8        movl    -24(%rbp), %esi
     34e:       f7 fe   idivl   %esi
     350:       6b c0 03        imull   $3, %eax, %eax
     353:       8b 7d f4        movl    -12(%rbp), %edi
     356:       89 45 e4        movl    %eax, -28(%rbp)
     359:       89 f8   movl    %edi, %eax
     35b:       99      cltd
     35c:       f7 fe   idivl   %esi
     35e:       8b 7d e4        movl    -28(%rbp), %edi
     361:       01 c7   addl    %eax, %edi
     363:       6b c7 0a        imull   $10, %edi, %eax
     366:       89 45 f0        movl    %eax, -16(%rbp)
     369:       8b 45 f8        movl    -8(%rbp), %eax
     36c:       99      cltd
     36d:       f7 fe   idivl   %esi
     36f:       6b c0 03        imull   $3, %eax, %eax
     372:       8b 7d f4        movl    -12(%rbp), %edi
     375:       89 45 e0        movl    %eax, -32(%rbp)
     378:       89 f8   movl    %edi, %eax
     37a:       99      cltd
     37b:       f7 fe   idivl   %esi
     37d:       8b 7d e0        movl    -32(%rbp), %edi
     380:       01 d7   addl    %edx, %edi
     382:       89 7d ec        movl    %edi, -20(%rbp)
     385:       8b 55 f0        movl    -16(%rbp), %edx
     388:       03 55 ec        addl    -20(%rbp), %edx
     38b:       89 d0   movl    %edx, %eax
     38d:       5d      popq    %rbp
     38e:       c3      retq
```

From instructions 339 to 33f we push the argument on the stack, so we can see that *n* is pushed from edx to -12(%rbp).

Next we see on instructions 353 and 53c that we are moving back *n* into edi and doing `n / 3`.
This manipulation is done a second time on instructions 373 and 37b to do `n % 3`.

I will try to save the two result and reuse them later, I'm gonna use `div_t div(int numerator, int denominator);` from the stdlib and see if I can lower the time spent in this function.

So now the function look like this ;

```C
static inline int HASH_BLOC(int x, int y, int n)
{
	div_t ndiv = div(n, 3);

	const int xp = (x / 3 * 3 + ndiv.quot) * 10;
	const int yp = y / 3 * 3 + ndiv.rem;

	return xp + yp;
}
```

-------------------------

Now everything is slow, after reading the source code of the div function I realized they were absolutly no optimisation so I'm gonna code my own div function to see if it's faster.

```c
static inline div_t my_div(int n)
{
	div_t div;
	__asm__ ( "movl $0x0, %%edx;"
			"movl %2, %%eax;"
			"movl $0x3, %%ebx;"
			"idivl %%ebx;" : "=a" (div.quot), "=d" (div.rem) : "g" (n) );
	return div;
}
```








