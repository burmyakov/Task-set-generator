SYSTEM     = x86-64_osx
LIBFORMAT  = static_pic

#------------------------------------------------------------
#
# When you adapt this makefile to compile your CPLEX programs
# please copy this makefile and set CPLEXDIR and CONCERTDIR to
# the directories where CPLEX and CONCERT are installed.
#
#------------------------------------------------------------

CPLEXDIR      = /Applications/CPLEX_Studio_Community2211/cplex
CONCERTDIR    = /Applications/CPLEX_Studio_Community2211/concert

# ---------------------------------------------------------------------
# Compiler selection
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Compiler options
# ---------------------------------------------------------------------

CCOPT = -m64 -O -fPIC -fexceptions -DNDEBUG -DIL_STD  -stdlib=libc++

# ---------------------------------------------------------------------
# Link options and libraries
# ---------------------------------------------------------------------

CPLEXLIBDIR   = $(CPLEXDIR)/lib/$(SYSTEM)/$(LIBFORMAT)
CONCERTLIBDIR = $(CONCERTDIR)/lib/$(SYSTEM)/$(LIBFORMAT)

CCLNDIRS  = -L$(CPLEXLIBDIR) -L$(CONCERTLIBDIR)
CCLNFLAGS = -lconcert -lilocplex -lcplex -m64 -lm -lpthread -framework CoreFoundation -framework IOKit -stdlib=libc++

CONCERTINCDIR = $(CONCERTDIR)/include
CPLEXINCDIR   = $(CPLEXDIR)/include
CCFLAGS = $(CCOPT) -I$(CPLEXINCDIR) -I$(CONCERTINCDIR)

OPTIONS = -ansi -Wall -Wno-sign-compare $(CCFLAGS) $(CCLNDIRS)
AUX = tasks_generator.cpp

all: generate_tasks.cpp $(AUX)
	g++ $(OPTIONS) -o generate_tasks generate_tasks.cpp $(AUX) $(CCLNFLAGS)

clean: 
	rm generate_tasks
