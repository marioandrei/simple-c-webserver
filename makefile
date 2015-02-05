################################################################################
# Simple Makefile 
# ref: ettp://www.cs.washington.edu/orgs/acm/tutorials/dev-in-unix/makefiles.html
################################################################################

# get all .c and also get the one with the  'int main' inside.
CC = gcc
#CFLAGS = -Wall -g -ansi -I .
CFLAGS = -Wall -g 
LDLIBS = -lm -lpthread
SOURCES = $(shell ls -1 *.c* | xargs)
EXEC_SOURCES = $(shell grep -l "^int main" $(SOURCES) | xargs)

# dependency files (.d) and executable names
EXECS = server
#$(shell echo $(EXEC_SOURCES) | sed -e 's:\.c[p]*::g')
DEPS = $(shell echo $(SOURCES) | sed -e 's:\.c[p]*:\.d:g')

#all contains the products
all:    server

# dependencies of the previous one 
server: server.o

# generate .d 
%.d : %.c
	@set -e; $(CC) -MM $(CFLAGS) $< \
		| sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
		[ -s $@ ] || rm -f $@

#flag include will contain the required .h
-include $(DEPS)

# generate .o
%.o :   %.c
	@echo -n compiling .o \'$<\'...
	@$(CC) $(CFLAGS) $< -c
	@echo [OK]

# generate exe if all the dependencies are ok
% :     %.o
	@echo -n compiling exe \'$@\'...
	@$(CC) $(CFLAGS) $^ -o $@ $(LDLIBS)
	@echo [OK]

# rm force all .o .d core files and executables
clean:  
	@rm -f $(wildcard *.o *.d core* *.P) $(EXECS)

# simple help
help:
	@echo "Use: make <target> ..."
	@echo "Valid targets:"
	@$(MAKE) --print-data-base --question | sed -e "s:makefile::g" |\
        awk '/^[^.%][-A-Za-z0-9_]*:/    \
                { print "   " substr($$1, 1, length($$1)-1) }'
