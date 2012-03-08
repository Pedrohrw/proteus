"""
Module for controlling MPI
"""
import sys
import flcbdfWrappers
initial_communicator = None

def init(petscDatabaseFilename=None,argv=sys.argv):
    global initial_communicator
    if initial_communicator == None:
        try:
            import petsc4py
            petsc4py.init(argv)
        except:
            print "WARNING petsc4py import failed!!!"
    if isinstance(petscDatabaseFilename,str):
        comm = flcbdfWrappers.DaetkPetscSys(argv,petscDatabaseFilename)
    else:
        comm = flcbdfWrappers.DaetkPetscSys(argv)
    if initial_communicator == None:
        initial_communicator = comm
    return comm

def get():
    if initial_communicator != None:
        return initial_communicator
    return flcbdfWrappers.getDaetkPetscSys()