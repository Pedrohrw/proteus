import numpy
cimport numpy

cdef extern from "mprans/PresInc.h" namespace "proteus":
    cdef cppclass cppPresInc_base:
        void calculateResidual(double * mesh_trial_ref,
                               double * mesh_grad_trial_ref,
                               double * mesh_dof,
                               int * mesh_l2g,
                               double * dV_ref,
                               double * u_trial_ref,
                               double * u_grad_trial_ref,
                               double * u_test_ref,
                               double * u_grad_test_ref,
                               double * mesh_trial_trace_ref,
                               double * mesh_grad_trial_trace_ref,
                               double * dS_ref,
                               double * u_trial_trace_ref,
                               double * u_grad_trial_trace_ref,
                               double * u_test_trace_ref,
                               double * u_grad_test_trace_ref,
                               double * normal_ref,
                               double * boundaryJac_ref,
                               int nElements_global,
                               int* isDOFBoundary,
                               int* isFluxBoundary,
                               int * u_l2g,
                               double * u_dof,
                               double alphaBDF,
                               double * q_vf,
			       double * q_divU,
                               double * q_vs,
                               double * q_vos,
                               double rho_s,
                               double * q_rho_f,
                               double rho_s_min,
                               double rho_f_min,
                               double * ebqe_vf,
                               double * ebqe_vs,
                               double * ebqe_vos,
                               double * ebqe_rho_f,
                               double * q_p,
                               double * q_grad_p,
                               double * ebqe_p,
                               double * ebqe_grad_p,
                               double* ebqe_bc_u_ext,
                               double* ebqe_adv_flux,
                               double* ebqe_diff_flux,
                               double* bc_diff_flux,
                               int offset_u,
                               int stride_u,
                               double * globalResidual,
                               int nExteriorElementBoundaries_global,
                               int * exteriorElementBoundariesArray,
                               int * elementBoundaryElementsArray,
                               int * elementBoundaryLocalElementBoundariesArray, 
			       int INTEGRATE_BY_PARTS_DIV_U,
                               double* q_a,
                               double* ebqe_a)
        void calculateJacobian(double * mesh_trial_ref,
                               double * mesh_grad_trial_ref,
                               double * mesh_dof,
                               int * mesh_l2g,
                               double * dV_ref,
                               double * u_trial_ref,
                               double * u_grad_trial_ref,
                               double * u_test_ref,
                               double * u_grad_test_ref,
                               double * mesh_trial_trace_ref,
                               double * mesh_grad_trial_trace_ref,
                               double * dS_ref,
                               double * u_trial_trace_ref,
                               double * u_grad_trial_trace_ref,
                               double * u_test_trace_ref,
                               double * u_grad_test_trace_ref,
                               double * normal_ref,
                               double * boundaryJac_ref,
                               int nElements_global,
                               int* isDOFBoundary,
                               int* isFluxBoundary,
                               int * u_l2g,
                               double * u_dof,
                               double alphaBDF,
                               double * q_vf,
                               double * q_vs,
                               double * q_vos,
                               double  rho_s,
                               double * q_rho_f,
                               double rho_s_min,
                               double rho_f_min,
                               double * ebqe_vf,
                               double * ebqe_vs,
                               double * ebqe_vos,
                               double * ebqe_rho_f,
                               int * csrRowIndeces_u_u,
                               int * csrColumnOffsets_u_u,
                               double * globalJacobian,
                               int nExteriorElementBoundaries_global,
                               int* exteriorElementBoundariesArray,
                               int* elementBoundaryElementsArray,
                               int* elementBoundaryLocalElementBoundariesArray,
                               int* csrColumnOffsets_eb_u_u)
    cppPresInc_base * newPresInc(int nSpaceIn,
                                 int nQuadraturePoints_elementIn,
                                 int nDOF_mesh_trial_elementIn,
                                 int nDOF_trial_elementIn,
                                 int nDOF_test_elementIn,
                                 int nQuadraturePoints_elementBoundaryIn,
                                 int CompKernelFlag)

cdef class PresInc:
    cdef cppPresInc_base * thisptr

    def __cinit__(self,
                  int nSpaceIn,
                  int nQuadraturePoints_elementIn,
                  int nDOF_mesh_trial_elementIn,
                  int nDOF_trial_elementIn,
                  int nDOF_test_elementIn,
                  int nQuadraturePoints_elementBoundaryIn,
                  int CompKernelFlag):
        self.thisptr = newPresInc(nSpaceIn,
                                  nQuadraturePoints_elementIn,
                                  nDOF_mesh_trial_elementIn,
                                  nDOF_trial_elementIn,
                                  nDOF_test_elementIn,
                                  nQuadraturePoints_elementBoundaryIn,
                                  CompKernelFlag)

    def __dealloc__(self):
        del self.thisptr

    def calculateResidual(self,
                          numpy.ndarray mesh_trial_ref,
                          numpy.ndarray mesh_grad_trial_ref,
                          numpy.ndarray mesh_dof,
                          numpy.ndarray mesh_l2g,
                          numpy.ndarray dV_ref,
                          numpy.ndarray u_trial_ref,
                          numpy.ndarray u_grad_trial_ref,
                          numpy.ndarray u_test_ref,
                          numpy.ndarray u_grad_test_ref,
                          numpy.ndarray mesh_trial_trace_ref,
                          numpy.ndarray mesh_grad_trial_trace_ref,
                          numpy.ndarray dS_ref,
                          numpy.ndarray u_trial_trace_ref,
                          numpy.ndarray u_grad_trial_trace_ref,
                          numpy.ndarray u_test_trace_ref,
                          numpy.ndarray u_grad_test_trace_ref,
                          numpy.ndarray normal_ref,
                          numpy.ndarray boundaryJac_ref,
                          int nElements_global,
                          numpy.ndarray isDOFBoundary,
                          numpy.ndarray isFluxBoundary,
                          numpy.ndarray u_l2g,
                          numpy.ndarray u_dof,
                          double alphaBDF,
                          numpy.ndarray q_vf,
			  numpy.ndarray q_divU,
                          numpy.ndarray q_vs,
                          numpy.ndarray q_vos,
                          double rho_s,
                          numpy.ndarray q_rho_f,
                          double rho_s_min,
                          double rho_f_min,
                          numpy.ndarray ebqe_vf,
                          numpy.ndarray ebqe_vs,
                          numpy.ndarray ebqe_vos,
                          numpy.ndarray ebqe_rho_f,
                          numpy.ndarray q_p,
                          numpy.ndarray q_grad_p,
                          numpy.ndarray ebqe_p,
                          numpy.ndarray ebqe_grad_p,
                          numpy.ndarray ebqe_bc_u_ext,
                          numpy.ndarray ebqe_adv_flux,
                          numpy.ndarray ebqe_diff_flux,
                          numpy.ndarray bc_diff_flux,
                          int offset_u,
                          int stride_u,
                          numpy.ndarray globalResidual,
                          int nExteriorElementBoundaries_global,
                          numpy.ndarray exteriorElementBoundariesArray,
                          numpy.ndarray elementBoundaryElementsArray,
                          numpy.ndarray elementBoundaryLocalElementBoundariesArray, 
			  int INTEGRATE_BY_PARTS_DIV_U,
                          numpy.ndarray q_a,
                          numpy.ndarray ebqe_a):
        self.thisptr.calculateResidual( < double*> mesh_trial_ref.data,
                                       < double * > mesh_grad_trial_ref.data,
                                       < double * > mesh_dof.data,
                                       < int * > mesh_l2g.data,
                                       < double * > dV_ref.data,
                                       < double * > u_trial_ref.data,
                                       < double * > u_grad_trial_ref.data,
                                       < double * > u_test_ref.data,
                                       < double * > u_grad_test_ref.data,
                                       < double * > mesh_trial_trace_ref.data,
                                       < double * > mesh_grad_trial_trace_ref.data,
                                       < double * > dS_ref.data,
                                       < double * > u_trial_trace_ref.data,
                                       < double * > u_grad_trial_trace_ref.data,
                                       < double * > u_test_trace_ref.data,
                                       < double * > u_grad_test_trace_ref.data,
                                       < double * > normal_ref.data,
                                       < double * > boundaryJac_ref.data,
                                       nElements_global,
                                        <int*> isDOFBoundary.data,
                                        <int*> isFluxBoundary.data,
                                       < int * > u_l2g.data,
                                       < double * > u_dof.data,
                                        alphaBDF,
                                       < double * > q_vf.data,
				       < double * > q_divU.data,
                                       < double * > q_vs.data,
                                       < double * > q_vos.data,
                                        rho_s,
                                       < double * > q_rho_f.data,
                                        rho_s_min,
                                        rho_f_min,
                                       < double * > ebqe_vf.data,
                                       < double * > ebqe_vs.data,
                                       < double * > ebqe_vos.data,
                                       < double * > ebqe_rho_f.data,
                                       < double * > q_p.data,
                                       < double * > q_grad_p.data,
                                       < double * > ebqe_p.data,
                                       < double * > ebqe_grad_p.data,
                                        < double* > ebqe_bc_u_ext.data,
                                        < double* > ebqe_adv_flux.data,
                                        < double* > ebqe_diff_flux.data,
                                        < double* > bc_diff_flux.data,
                                       offset_u,
                                       stride_u,
                                       < double * > globalResidual.data,
                                       nExteriorElementBoundaries_global,
                                       < int * > exteriorElementBoundariesArray.data,
                                       < int * > elementBoundaryElementsArray.data,
                                       < int * > elementBoundaryLocalElementBoundariesArray.data, 
				        INTEGRATE_BY_PARTS_DIV_U,
                                        <double*> q_a.data,
                                        <double*> ebqe_a.data)

    def calculateJacobian(self,
                          numpy.ndarray mesh_trial_ref,
                          numpy.ndarray mesh_grad_trial_ref,
                          numpy.ndarray mesh_dof,
                          numpy.ndarray mesh_l2g,
                          numpy.ndarray dV_ref,
                          numpy.ndarray u_trial_ref,
                          numpy.ndarray u_grad_trial_ref,
                          numpy.ndarray u_test_ref,
                          numpy.ndarray u_grad_test_ref,
                          numpy.ndarray mesh_trial_trace_ref,
                          numpy.ndarray mesh_grad_trial_trace_ref,
                          numpy.ndarray dS_ref,
                          numpy.ndarray u_trial_trace_ref,
                          numpy.ndarray u_grad_trial_trace_ref,
                          numpy.ndarray u_test_trace_ref,
                          numpy.ndarray u_grad_test_trace_ref,
                          numpy.ndarray normal_ref,
                          numpy.ndarray boundaryJac_ref,
                          int nElements_global,
                          numpy.ndarray isDOFBoundary,
                          numpy.ndarray isFluxBoundary,
                          numpy.ndarray u_l2g,
                          numpy.ndarray u_dof,
                          double alphaBDF,
                          numpy.ndarray q_vf,
                          numpy.ndarray q_vs,
                          numpy.ndarray q_vos,
                          double rho_s,
                          numpy.ndarray q_rho_f,
                          double rho_s_min,
                          double rho_f_min,
                          numpy.ndarray ebqe_vf,
                          numpy.ndarray ebqe_vs,
                          numpy.ndarray ebqe_vos,
                          numpy.ndarray ebqe_rho_f,
                          numpy.ndarray csrRowIndeces_u_u,
                          numpy.ndarray csrColumnOffsets_u_u,
                          globalJacobian,
                          int nExteriorElementBoundaries_global,
			  numpy.ndarray exteriorElementBoundariesArray,
			  numpy.ndarray elementBoundaryElementsArray,
			  numpy.ndarray elementBoundaryLocalElementBoundariesArray,
                          numpy.ndarray csrColumnOffsets_eb_u_u):
        cdef numpy.ndarray rowptr, colind, globalJacobian_a
        (rowptr, colind, globalJacobian_a) = globalJacobian.getCSRrepresentation()
        self.thisptr.calculateJacobian( < double*> mesh_trial_ref.data,
                                        < double * > mesh_grad_trial_ref.data,
                                        < double * > mesh_dof.data,
                                        < int * > mesh_l2g.data,
                                        < double * > dV_ref.data,
                                        < double * > u_trial_ref.data,
                                        < double * > u_grad_trial_ref.data,
                                        < double * > u_test_ref.data,
                                        < double * > u_grad_test_ref.data,
                                        < double * > mesh_trial_trace_ref.data,
                                        < double * > mesh_grad_trial_trace_ref.data,
                                        < double * > dS_ref.data,
                                        < double * > u_trial_trace_ref.data,
                                        < double * > u_grad_trial_trace_ref.data,
                                        < double * > u_test_trace_ref.data,
                                        < double * > u_grad_test_trace_ref.data,
                                        < double * > normal_ref.data,
                                        < double * > boundaryJac_ref.data,
                                        nElements_global,
                                        < int* > isDOFBoundary.data,
                                        < int* > isFluxBoundary.data,
                                        < int * > u_l2g.data,
                                        < double * > u_dof.data,
                                        alphaBDF,
                                        < double * > q_vf.data,
                                        < double * > q_vs.data,
                                        < double * > q_vos.data,
                                        rho_s,
                                        < double * > q_rho_f.data,
                                        rho_s_min,
                                        rho_f_min,
                                        < double * > ebqe_vf.data,
                                        < double * > ebqe_vs.data,
                                        < double * > ebqe_vos.data,
                                        < double * > ebqe_rho_f.data,
                                        < int * > csrRowIndeces_u_u.data,
                                        < int * > csrColumnOffsets_u_u.data,
                                        < double * > globalJacobian_a.data,
                                        nExteriorElementBoundaries_global,
				        < int* > exteriorElementBoundariesArray.data,
				        < int* > elementBoundaryElementsArray.data,
				        < int* > elementBoundaryLocalElementBoundariesArray.data,
                                        < int* > csrColumnOffsets_eb_u_u.data)
