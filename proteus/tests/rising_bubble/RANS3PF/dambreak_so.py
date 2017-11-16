from proteus.default_so import *
import dambreak

from proteus.SplitOperator import Sequential_FixedStep_Simple, defaultSystem

pnList = [("vof_p",               "vof_n"),#0
          ("ls_p",                "ls_n"),#1
          ("redist_p",            "redist_n"),#2
          ("ls_consrv_p",         "ls_consrv_n"),#3
          ("twp_navier_stokes_p", "twp_navier_stokes_n"),#4
          ("pressureincrement_p", "pressureincrement_n"),#5
          ("pressure_p", "pressure_n"),#6
          ("pressureInitial_p", "pressureInitial_n")]#7
dambreak.VOS_model=None
dambreak.SED_model=None
dambreak.VOF_model=0
dambreak.LS_model=1
dambreak.RD_model=2
dambreak.MCORR_model=3
dambreak.V_model=4
dambreak.PINC_model=5
dambreak.PRESSURE_model=6
dambreak.PINIT_model=7

name = "dambreak"

#modelSpinUpList = [dambreak.VOF_model, dambreak.LS_model, dambreak.V_model, dambreak.PINIT_model]
modelSpinUpList = [dambreak.PINIT_model]

class Sequential_MinAdaptiveModelStepPS(Sequential_MinAdaptiveModelStep):
    def __init__(self,modelList,system=defaultSystem,stepExact=True):
        Sequential_MinAdaptiveModelStep.__init__(self,modelList,system,stepExact)
        self.modelList = modelList[:len(pnList)-1]


systemStepControllerType = Sequential_MinAdaptiveModelStepPS

needEBQ_GLOBAL = False
needEBQ = False

tnList = [0.0,dambreak.dt_init]+[i*dambreak.dt_fixed for i in range(1,dambreak.nDTout+1)]

info = open("TimeList.txt","w")
#archiveFlag = ArchiveFlags.EVERY_SEQUENCE_STEP
