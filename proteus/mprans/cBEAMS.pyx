import numpy
cimport numpy
from proteus import *
from proteus.Transport import *
from proteus.Transport import OneLevelTransport

cdef extern from "BEAMS.h" namespace "proteus":
    cdef cppclass BEAMS_base:
        void calculateBeams(double* mesh_trial_ref,
                               double* mesh_grad_trial_ref,
                               double* mesh_dof,
                               double* mesh_velocity_dof,
                               double MOVING_DOMAIN,
				   int* mesh_l2g,
				   double* dV_ref,
				   double* p_trial_ref,
				   double* p_grad_trial_ref,
				   double* p_test_ref,
				   double* p_grad_test_ref,
				   double* vel_trial_ref,
				   double* vel_grad_trial_ref,
				   double* vel_test_ref,
				   double* vel_grad_test_ref,
				   double* mesh_trial_trace_ref,
				   double* mesh_grad_trial_trace_ref,
				   double* dS_ref,
				   double* p_trial_trace_ref,
				   double* p_grad_trial_trace_ref,
				   double* p_test_trace_ref,
				   double* p_grad_test_trace_ref,
				   double* vel_trial_trace_ref,
				   double* vel_grad_trial_trace_ref,
				   double* vel_test_trace_ref,
				   double* vel_grad_test_trace_ref,					 
				   double* normal_ref,
				   double* boundaryJac_ref,
				   double eb_adjoint_sigma,
				   double* elementDiameter,
				   double* nodeDiametersArray,
				   double hFactor,
				   int nElements_global,
				   int nElementBoundaries_owned,
				   double useRBLES,
				   double useMetrics, 
				   double alphaBDF,
				   double epsFact_rho,
				   double epsFact_mu, 
				   double sigma,
				   double rho_0,
				   double nu_0,
				   double rho_1,
				   double nu_1,
				   double smagorinskyConstant,
				   int turbulenceClosureModel,
				   double Ct_sge,
				   double Cd_sge,
				   double C_dc,
				   double C_b,
# VRANS start
				   double* eps_solid,
				   double* phi_solid,
				   double* q_velocity_solid,
				   double* q_porosity,
				   double* q_dragAlpha,
				   double* q_dragBeta,
				   double* q_mass_source,
				   double* q_turb_var_0,
				   double* q_turb_var_1,
				   double* q_turb_var_grad_0,
# VRANS end
				   int* p_l2g, 
				   int* vel_l2g, 
				   double* p_dof, 
				   double* u_dof, 
				   double* v_dof, 
				   double* w_dof,
				   double* g,
				   double useVF,
				   double* vf,
				   double* phi,
				   double* normal_phi,
				   double* kappa_phi,
				   double* q_mom_u_acc,
				   double* q_mom_v_acc,
				   double* q_mom_w_acc,
				   double* q_mass_adv,
				   double* q_mom_u_acc_beta_bdf, double* q_mom_v_acc_beta_bdf, double* q_mom_w_acc_beta_bdf,
				   double* q_velocity_sge,
				   double* q_cfl,
				   double* q_numDiff_u, double* q_numDiff_v, double* q_numDiff_w,
				   double* q_numDiff_u_last, double* q_numDiff_v_last, double* q_numDiff_w_last,
				   int* sdInfo_u_u_rowptr,int* sdInfo_u_u_colind,			      
				   int* sdInfo_u_v_rowptr,int* sdInfo_u_v_colind,
				   int* sdInfo_u_w_rowptr,int* sdInfo_u_w_colind,
				   int* sdInfo_v_v_rowptr,int* sdInfo_v_v_colind,
				   int* sdInfo_v_u_rowptr,int* sdInfo_v_u_colind,
				   int* sdInfo_v_w_rowptr,int* sdInfo_v_w_colind,
				   int* sdInfo_w_w_rowptr,int* sdInfo_w_w_colind,
				   int* sdInfo_w_u_rowptr,int* sdInfo_w_u_colind,
				   int* sdInfo_w_v_rowptr,int* sdInfo_w_v_colind,
				   int offset_p, int offset_u, int offset_v, int offset_w, 
				   int stride_p, int stride_u, int stride_v, int stride_w, 
				   double* globalResidual,
				   int nExteriorElementBoundaries_global,
				   int* exteriorElementBoundariesArray,
				   int* elementBoundaryElementsArray,
				   int* elementBoundaryLocalElementBoundariesArray,
				   double* ebqe_vf_ext,
				   double* bc_ebqe_vf_ext,
				   double* ebqe_phi_ext,
				   double* bc_ebqe_phi_ext,
				   double* ebqe_normal_phi_ext,
				   double* ebqe_kappa_phi_ext,
# VRANS start
				   double* ebqe_porosity_ext,
                                   double* ebqe_turb_var_0,
				   double* ebqe_turb_var_1,
# VRANS end
				   int* isDOFBoundary_p,
				   int* isDOFBoundary_u,
				   int* isDOFBoundary_v,
				   int* isDOFBoundary_w,
				   int* isAdvectiveFluxBoundary_p,
				   int* isAdvectiveFluxBoundary_u,
				   int* isAdvectiveFluxBoundary_v,
				   int* isAdvectiveFluxBoundary_w,
				   int* isDiffusiveFluxBoundary_u,
				   int* isDiffusiveFluxBoundary_v,
				   int* isDiffusiveFluxBoundary_w,
				   double* ebqe_bc_p_ext,
				   double* ebqe_bc_flux_mass_ext,
				   double* ebqe_bc_flux_mom_u_adv_ext,
				   double* ebqe_bc_flux_mom_v_adv_ext,
				   double* ebqe_bc_flux_mom_w_adv_ext,
				   double* ebqe_bc_u_ext,
				   double* ebqe_bc_flux_u_diff_ext,
				   double* ebqe_penalty_ext,
				   double* ebqe_bc_v_ext,
				   double* ebqe_bc_flux_v_diff_ext,
				   double* ebqe_bc_w_ext,
				   double* ebqe_bc_flux_w_diff_ext,
				   double* q_x,
				   double* q_velocity,
				   double* ebqe_velocity,
				   double* flux,
                                   double* elementResidual_p,
				   int* boundaryFlags,
				   double* barycenters,
				   double* wettedAreas,
				   double* netForces_p,
				   double* netForces_v,
				   double* netMoments,
				   double* q_dragBeam1,
				   double* q_dragBeam2,
				   double* q_dragBeam3,
				   double* ebqe_dragBeam1,
				   double* ebqe_dragBeam2,
				   double* ebqe_dragBeam3,
				   int nBeams,
				int nBeamElements,
				int beam_quadOrder,
				double beam_Cd,
				double* beamRadius,
				double* xq,
				double* yq,
				double* zq,
				double* Beam_h,
				double* dV_beam,
				double* q1,
				double* q2,
				double* q3,
				double* vel_avg,
				double* netBeamDrag,
				int* beamIsLocal)       
     
    BEAMS_base* newBEAMS(int nSpaceIn,
                           int nQuadraturePoints_elementIn,
                           int nDOF_mesh_trial_elementIn,
                           int nDOF_trial_elementIn,
                           int nDOF_test_elementIn,
                           int nQuadraturePoints_elementBoundaryIn,
                           int CompKernelFlag)

cdef class cBEAMS_base:
   cdef BEAMS_base* thisptr
   def __cinit__(self,
                 int nSpaceIn,
                 int nQuadraturePoints_elementIn,
                 int nDOF_mesh_trial_elementIn,
                 int nDOF_trial_elementIn,
                 int nDOF_test_elementIn,
                 int nQuadraturePoints_elementBoundaryIn,
                 int CompKernelFlag):
       self.thisptr = newBEAMS(nSpaceIn,
                              nQuadraturePoints_elementIn,
                              nDOF_mesh_trial_elementIn,
                              nDOF_trial_elementIn,
                              nDOF_test_elementIn,
                              nQuadraturePoints_elementBoundaryIn,
                              CompKernelFlag)
   def __dealloc__(self):
       del self.thisptr
   		 


   def calculateBeams(self,
                         numpy.ndarray mesh_trial_ref,
                         numpy.ndarray mesh_grad_trial_ref,
                         numpy.ndarray mesh_dof,
                         numpy.ndarray mesh_velocity_dof,
                         double MOVING_DOMAIN,
                         numpy.ndarray mesh_l2g,
                         numpy.ndarray dV_ref,
                         numpy.ndarray p_trial_ref,
                         numpy.ndarray p_grad_trial_ref,
                         numpy.ndarray p_test_ref,
                         numpy.ndarray p_grad_test_ref,
                         numpy.ndarray vel_trial_ref,
                         numpy.ndarray vel_grad_trial_ref,
                         numpy.ndarray vel_test_ref,
                         numpy.ndarray vel_grad_test_ref,
                         numpy.ndarray mesh_trial_trace_ref,
                         numpy.ndarray mesh_grad_trial_trace_ref,
                         numpy.ndarray dS_ref,
                         numpy.ndarray p_trial_trace_ref,
                         numpy.ndarray p_grad_trial_trace_ref,
                         numpy.ndarray p_test_trace_ref,
                         numpy.ndarray p_grad_test_trace_ref,
                         numpy.ndarray vel_trial_trace_ref,
                         numpy.ndarray vel_grad_trial_trace_ref,
                         numpy.ndarray vel_test_trace_ref,
                         numpy.ndarray vel_grad_test_trace_ref,					 
                         numpy.ndarray normal_ref,
                         numpy.ndarray boundaryJac_ref,
			 double eb_adjoint_sigma,
                         numpy.ndarray elementDiameter,
			 numpy.ndarray nodeDiametersArray,
			 double hFactor,
                         int nElements_global,
			 int nElementBoundaries_owned,
			 double useRBLES,
			 double useMetrics, 
                         double alphaBDF,
                         double epsFact_rho,
                         double epsFact_mu, 
                         double sigma,
                         double rho_0,
                         double nu_0,
                         double rho_1,
                         double nu_1,
			 double smagorinskyConstant,
			 int turbulenceClosureModel,
                         double Ct_sge,
                         double Cd_sge,
                         double C_dc,
			 double C_b,
# VRANS start
			 numpy.ndarray eps_solid,
		         numpy.ndarray phi_solid,
			 numpy.ndarray q_velocity_solid,
                         numpy.ndarray q_porosity,
                         numpy.ndarray q_dragAlpha,
                         numpy.ndarray q_dragBeta,
                         numpy.ndarray q_mass_source,
                         numpy.ndarray q_turb_var_0,
                         numpy.ndarray q_turb_var_1,
                         numpy.ndarray q_turb_var_grad_0,
# VRANS end
                         numpy.ndarray p_l2g, 
                         numpy.ndarray vel_l2g, 
                         numpy.ndarray p_dof, 
                         numpy.ndarray u_dof, 
                         numpy.ndarray v_dof, 
                         numpy.ndarray w_dof,
                         numpy.ndarray g,
			 double useVF,
			 numpy.ndarray vf,
                         numpy.ndarray phi,
                         numpy.ndarray normal_phi,
                         numpy.ndarray kappa_phi,
                         numpy.ndarray q_mom_u_acc,
                         numpy.ndarray q_mom_v_acc,
                         numpy.ndarray q_mom_w_acc,
                         numpy.ndarray q_mass_adv,
                         numpy.ndarray q_mom_u_acc_beta_bdf, numpy.ndarray q_mom_v_acc_beta_bdf, numpy.ndarray q_mom_w_acc_beta_bdf,
                         numpy.ndarray q_velocity_sge,
                         numpy.ndarray q_cfl,
                         numpy.ndarray q_numDiff_u, numpy.ndarray q_numDiff_v, numpy.ndarray q_numDiff_w,
                         numpy.ndarray q_numDiff_u_last, numpy.ndarray q_numDiff_v_last, numpy.ndarray q_numDiff_w_last,
                         numpy.ndarray sdInfo_u_u_rowptr,numpy.ndarray sdInfo_u_u_colind,			      
                         numpy.ndarray sdInfo_u_v_rowptr,numpy.ndarray sdInfo_u_v_colind,
                         numpy.ndarray sdInfo_u_w_rowptr,numpy.ndarray sdInfo_u_w_colind,
                         numpy.ndarray sdInfo_v_v_rowptr,numpy.ndarray sdInfo_v_v_colind,
                         numpy.ndarray sdInfo_v_u_rowptr,numpy.ndarray sdInfo_v_u_colind,
                         numpy.ndarray sdInfo_v_w_rowptr,numpy.ndarray sdInfo_v_w_colind,
                         numpy.ndarray sdInfo_w_w_rowptr,numpy.ndarray sdInfo_w_w_colind,
                         numpy.ndarray sdInfo_w_u_rowptr,numpy.ndarray sdInfo_w_u_colind,
                         numpy.ndarray sdInfo_w_v_rowptr,numpy.ndarray sdInfo_w_v_colind,
                         int offset_p, int offset_u, int offset_v, int offset_w, 
                         int stride_p, int stride_u, int stride_v, int stride_w, 
                         numpy.ndarray globalResidual,
                         int nExteriorElementBoundaries_global,
                         numpy.ndarray exteriorElementBoundariesArray,
                         numpy.ndarray elementBoundaryElementsArray,
                         numpy.ndarray elementBoundaryLocalElementBoundariesArray,
			 numpy.ndarray ebqe_vf_ext,
			 numpy.ndarray bc_ebqe_vf_ext,
                         numpy.ndarray ebqe_phi_ext,
                         numpy.ndarray bc_ebqe_phi_ext,
                         numpy.ndarray ebqe_normal_phi_ext,
                         numpy.ndarray ebqe_kappa_phi_ext,
# VRANS start
                         numpy.ndarray ebqe_porosity_ext,
                         numpy.ndarray ebqe_turb_var_0,
                         numpy.ndarray ebqe_turb_var_1,
# VRANS end
                         numpy.ndarray isDOFBoundary_p,
                         numpy.ndarray isDOFBoundary_u,
                         numpy.ndarray isDOFBoundary_v,
                         numpy.ndarray isDOFBoundary_w,
                         numpy.ndarray isAdvectiveFluxBoundary_p,
                         numpy.ndarray isAdvectiveFluxBoundary_u,
                         numpy.ndarray isAdvectiveFluxBoundary_v,
                         numpy.ndarray isAdvectiveFluxBoundary_w,
                         numpy.ndarray isDiffusiveFluxBoundary_u,
                         numpy.ndarray isDiffusiveFluxBoundary_v,
                         numpy.ndarray isDiffusiveFluxBoundary_w,
                         numpy.ndarray ebqe_bc_p_ext,
                         numpy.ndarray ebqe_bc_flux_mass_ext,
                         numpy.ndarray ebqe_bc_flux_mom_u_adv_ext,
                         numpy.ndarray ebqe_bc_flux_mom_v_adv_ext,
                         numpy.ndarray ebqe_bc_flux_mom_w_adv_ext,
                         numpy.ndarray ebqe_bc_u_ext,
                         numpy.ndarray ebqe_bc_flux_u_diff_ext,
                         numpy.ndarray ebqe_penalty_ext,
                         numpy.ndarray ebqe_bc_v_ext,
                         numpy.ndarray ebqe_bc_flux_v_diff_ext,
                         numpy.ndarray ebqe_bc_w_ext,
                         numpy.ndarray ebqe_bc_flux_w_diff_ext,
                         numpy.ndarray q_x,
                         numpy.ndarray q_velocity,
                         numpy.ndarray ebqe_velocity,
                         numpy.ndarray flux,
                         numpy.ndarray elementResidual_p,
			 numpy.ndarray boundaryFlags,
			 numpy.ndarray barycenters,
			 numpy.ndarray wettedAreas,
			 numpy.ndarray netForces_p,
			 numpy.ndarray netForces_v,
			 numpy.ndarray netMoments,
			 numpy.ndarray q_dragBeam1,
				   numpy.ndarray q_dragBeam2,
				   numpy.ndarray q_dragBeam3,
				   numpy.ndarray ebqe_dragBeam1,
				   numpy.ndarray ebqe_dragBeam2,
				   numpy.ndarray ebqe_dragBeam3,
				   int nBeams,
			 int nBeamElements,
			 int beam_quadOrder,
			 double beam_Cd,
			 numpy.ndarray beamRadius,
			 numpy.ndarray xq,
			 numpy.ndarray yq,
			 numpy.ndarray zq,
			 numpy.ndarray Beam_h,
			 numpy.ndarray dV_beam,
			 numpy.ndarray q1,
			 numpy.ndarray q2,
			 numpy.ndarray q3,
			 numpy.ndarray vel_avg,
			 numpy.ndarray netBeamDrag,
			 numpy.ndarray beamIsLocal):			 
       self.thisptr.calculateBeams(<double*> mesh_trial_ref.data,
                                       <double*> mesh_grad_trial_ref.data,
                                       <double*> mesh_dof.data,
                                       <double*> mesh_velocity_dof.data,
                                       MOVING_DOMAIN,
                                       <int*> mesh_l2g.data,
                                       <double*> dV_ref.data,
                                       <double*> p_trial_ref.data,
                                       <double*> p_grad_trial_ref.data,
                                       <double*> p_test_ref.data,
                                       <double*> p_grad_test_ref.data,
                                       <double*> vel_trial_ref.data,
                                       <double*> vel_grad_trial_ref.data,
                                       <double*> vel_test_ref.data,
                                       <double*> vel_grad_test_ref.data,
                                       <double*> mesh_trial_trace_ref.data,
                                       <double*> mesh_grad_trial_trace_ref.data,
                                       <double*> dS_ref.data,
                                       <double*> p_trial_trace_ref.data,
                                       <double*> p_grad_trial_trace_ref.data,
                                       <double*> p_test_trace_ref.data,
                                       <double*> p_grad_test_trace_ref.data,
                                       <double*> vel_trial_trace_ref.data,
                                       <double*> vel_grad_trial_trace_ref.data,
                                       <double*> vel_test_trace_ref.data,
                                       <double*> vel_grad_test_trace_ref.data,					 
                                       <double*> normal_ref.data,
                                       <double*> boundaryJac_ref.data,
				       eb_adjoint_sigma,
                                       <double*> elementDiameter.data,
				       <double*> nodeDiametersArray.data,
                                       hFactor,
                                       nElements_global,
				       nElementBoundaries_owned,
				       useRBLES,
				       useMetrics, 
                                       alphaBDF,
                                       epsFact_rho,
                                       epsFact_mu, 
                                       sigma,
                                       rho_0,
                                       nu_0,
                                       rho_1,
                                       nu_1,
				       smagorinskyConstant,
				       turbulenceClosureModel,
                                       Ct_sge,
                                       Cd_sge,
                                       C_dc,
				       C_b,
# VRANS start
				       <double*> eps_solid.data,
				       <double*> phi_solid.data,
				       <double*> q_velocity_solid.data,
                                       <double*> q_porosity.data,
                                       <double*> q_dragAlpha.data,
                                       <double*> q_dragBeta.data,
                                       <double*> q_mass_source.data,
                                       <double*> q_turb_var_0.data,
                                       <double*> q_turb_var_1.data,
                                       <double*> q_turb_var_grad_0.data,
# VRANS end
                                       <int*> p_l2g.data, 
                                       <int*> vel_l2g.data, 
                                       <double*> p_dof.data, 
                                       <double*> u_dof.data, 
                                       <double*> v_dof.data, 
                                       <double*> w_dof.data,
                                       <double*> g.data,
				       useVF,
				       <double*> vf.data,
                                       <double*> phi.data,
                                       <double*> normal_phi.data,
                                       <double*> kappa_phi.data,
                                       <double*> q_mom_u_acc.data,
                                       <double*> q_mom_v_acc.data,
                                       <double*> q_mom_w_acc.data,
                                       <double*> q_mass_adv.data,
                                       <double*> q_mom_u_acc_beta_bdf.data, <double*> q_mom_v_acc_beta_bdf.data, <double*> q_mom_w_acc_beta_bdf.data,
                                       <double*> q_velocity_sge.data,
                                       <double*> q_cfl.data,
                                       <double*> q_numDiff_u.data, <double*> q_numDiff_v.data, <double*> q_numDiff_w.data,
                                       <double*> q_numDiff_u_last.data, <double*> q_numDiff_v_last.data, <double*> q_numDiff_w_last.data,
                                       <int*> sdInfo_u_u_rowptr.data,<int*> sdInfo_u_u_colind.data,			      
                                       <int*> sdInfo_u_v_rowptr.data,<int*> sdInfo_u_v_colind.data,
                                       <int*> sdInfo_u_w_rowptr.data,<int*> sdInfo_u_w_colind.data,
                                       <int*> sdInfo_v_v_rowptr.data,<int*> sdInfo_v_v_colind.data,
                                       <int*> sdInfo_v_u_rowptr.data,<int*> sdInfo_v_u_colind.data,
                                       <int*> sdInfo_v_w_rowptr.data,<int*> sdInfo_v_w_colind.data,
                                       <int*> sdInfo_w_w_rowptr.data,<int*> sdInfo_w_w_colind.data,
                                       <int*> sdInfo_w_u_rowptr.data,<int*> sdInfo_w_u_colind.data,
                                       <int*> sdInfo_w_v_rowptr.data,<int*> sdInfo_w_v_colind.data,
                                       offset_p, offset_u, offset_v, offset_w, 
                                       stride_p, stride_u, stride_v, stride_w, 
                                       <double*> globalResidual.data,
                                       nExteriorElementBoundaries_global,
                                       <int*> exteriorElementBoundariesArray.data,
                                       <int*> elementBoundaryElementsArray.data,
                                       <int*> elementBoundaryLocalElementBoundariesArray.data,
				       <double*> ebqe_vf_ext.data,
				       <double*> bc_ebqe_vf_ext.data,
                                       <double*> ebqe_phi_ext.data,
                                       <double*> bc_ebqe_phi_ext.data,
                                       <double*> ebqe_normal_phi_ext.data,
                                       <double*> ebqe_kappa_phi_ext.data,
# VRANS start
                                       <double*> ebqe_porosity_ext.data,
                                       <double*> ebqe_turb_var_0.data,
                                       <double*> ebqe_turb_var_1.data,
# VRANS end
                                       <int*> isDOFBoundary_p.data,
                                       <int*> isDOFBoundary_u.data,
                                       <int*> isDOFBoundary_v.data,
                                       <int*> isDOFBoundary_w.data,
                                       <int*> isAdvectiveFluxBoundary_p.data,
                                       <int*> isAdvectiveFluxBoundary_u.data,
                                       <int*> isAdvectiveFluxBoundary_v.data,
                                       <int*> isAdvectiveFluxBoundary_w.data,
                                       <int*> isDiffusiveFluxBoundary_u.data,
                                       <int*> isDiffusiveFluxBoundary_v.data,
                                       <int*> isDiffusiveFluxBoundary_w.data,
                                       <double*> ebqe_bc_p_ext.data,
                                       <double*> ebqe_bc_flux_mass_ext.data,
                                       <double*> ebqe_bc_flux_mom_u_adv_ext.data,
                                       <double*> ebqe_bc_flux_mom_v_adv_ext.data,
                                       <double*> ebqe_bc_flux_mom_w_adv_ext.data,
                                       <double*> ebqe_bc_u_ext.data,
                                       <double*> ebqe_bc_flux_u_diff_ext.data,
                                       <double*> ebqe_penalty_ext.data,
                                       <double*> ebqe_bc_v_ext.data,
                                       <double*> ebqe_bc_flux_v_diff_ext.data,
                                       <double*> ebqe_bc_w_ext.data,
                                       <double*> ebqe_bc_flux_w_diff_ext.data,
                                       <double*> q_x.data,
                                       <double*> q_velocity.data,
                                       <double*> ebqe_velocity.data,
                                       <double*> flux.data,
                                       <double*> elementResidual_p.data,
				       <int*> boundaryFlags.data,
				       <double*> barycenters.data,
				       <double*> wettedAreas.data,
				       <double*> netForces_p.data,
				       <double*> netForces_v.data,
				       <double*> netMoments.data,
				       <double*> q_dragBeam1.data,
				   <double*> q_dragBeam2.data,
				   <double*> q_dragBeam3.data,
				   <double*> ebqe_dragBeam1.data,
				   <double*> ebqe_dragBeam2.data,
				   <double*> ebqe_dragBeam3.data,
				   nBeams,
				       nBeamElements,
				       beam_quadOrder,
				       beam_Cd,
				       <double*> beamRadius.data,
				       <double*> xq.data,
				       <double*> yq.data,
				       <double*> zq.data,
				       <double*> Beam_h.data,
				       <double*> dV_beam.data,
				       <double*> q1.data,
				       <double*> q2.data,
				       <double*> q3.data,
				       <double*> vel_avg.data,
				       <double*> netBeamDrag.data,
				       <int*> beamIsLocal.data)
			       
   