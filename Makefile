all: test.a testdl.o libfpc.a static

test.a: test.o
	ar cru test.a test.o

test.s test.ppu: test.pas
	fpc -a -al -an -ar -at -AAS -Cg -CD -g -gv -s -XS -Xt -Rintel -Sc -Si -Sm -us test.pas

testdl.s: testdl.pas
	fpc -a -al -an -ar -at -AAS -Cg -CD -g -gv -s -XS -Xt -Rintel -Sc -Si -Sm -us testdl.pas

test.o: test.s
	as -o test.o test.s

testdl.o: testdl.s
	as -o testdl.o testdl.s

static: static.o
	gcc -Xlinker --strip-all -Xlinker --gc-sections -o static static.o test.a testdl.o libfpc.a

static.o: static.c
	gcc -c -o static.o static.c
	
FPCLIBROOT=C:\Prg\Dev\lazarus\fpc
FPCLIBVER=2.7.1
FPCLIBTARGET=i386-win32
FPCLIB=$(FPCLIBROOT)\$(FPCLIBVER)\units\$(FPCLIBTARGET)

libfpc.a:
	-rm -rf tmplibfpc
	mkdir tmplibfpc
	cd tmplibfpc && \
    	ar x $(FPCLIB)\rtl\libimpsystem.a && \
    	ar x $(FPCLIB)\rtl\libimpsysutils.a && \
		ar x $(FPCLIB)\rtl\libimpwindows.a && \
		ar x $(FPCLIB)\rtl\libimpcmem.a && \
		ar x $(FPCLIB)\rtl\libimpvarutils.a
	objcopy -N_mainCRTStartup -N_WinMainCRTStartup -N_tls_used -N__tls_used $(FPCLIB)\rtl\sysinitpas.o tmplibfpc\sysinitpas.o
	ar cru libfpc.a \
		$(FPCLIB)\rtl\system.o $(FPCLIB)\rtl\sysutils.o $(FPCLIB)\rtl\sysconst.o $(FPCLIB)\rtl\objpas.o \
		$(FPCLIB)\rtl\fpintres.o \
		$(FPCLIB)\rtl\cmem.o \
		$(FPCLIB)\rtl\windirs.o $(FPCLIB)\rtl\windows.o \
		tmplibfpc\\*.o
	-rm -rf tmplibfpc

.PHONY: clean
clean:
	-rm -f *.s
	-rm -f *.o
	-rm -f *.a
	-rm -f *.ppu
	-rm -f static.o
	-rm -f static
	-rm -f lib*.so
	-rm -f ppas.sh ppas.bat
