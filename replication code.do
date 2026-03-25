
*Replication Code for Dalle & Carrascosa (2026)



**Table 1

tab clase5enccomb if ENCUESTA!=2016
tab clase5oricomb  if ENCUESTA!=2016
tab sexocomb if ENCUESTA!=2016
tab om12y3vf if ENCUESTA!=2016
tab educcomb if ENCUESTA!=2016



** Table A-1
tab omfcomb oretfx2_comb if ENCUESTA!=2016 , cell nofre



*Table A-2 - Gross effects
		 
mlogit clase5enccomb i.clase5oricomb if edadcomb>=25 & ENCUESTA!=2016,  baseoutcome(5)
est sto m1

mlogit clase5enccomb i.sexocomb if edadcomb>=25 & ENCUESTA!=2016,  baseoutcome(5)
est sto m2

mlogit clase5enccomb i.om12y3vf if edadcomb>=25 & ENCUESTA!=2016,  baseoutcome(5)
est sto m3

mlogit clase5enccomb i.educcomb if edadcomb>=25 & ENCUESTA!=2016,  baseoutcome(5)
est sto m4

	outreg2 [m1 m2 m3 m4] using gross_effects.xls, replace label  dec(2) alpha(0.001, 0.01, 0.05)
 
 
 
 
 *Table A-3 / Figure 1- Mlogit models
 
mlogit clase5enccomb i.sexocomb i.clase5oricomb if edadcomb>=25 & clase5oricomb!=. & om12y3vf!=. & ENCUESTA!=2016, baseoutcome(5) vce(robust)
est sto m1
mlogit clase5enccomb i.clase5oricomb i.sexocomb i.om12y3vf if edadcomb>=25 & ENCUESTA!=2016,  baseoutcome(5) vce(robust)
est sto m2
mlogit clase5enccomb i.clase5oricomb i.sexocomb i.om12y3vf i.educcomb if edadcomb>=25 & ENCUESTA!=2016,  baseoutcome(5) vce(robust)
est sto m3


outreg2 [m1 m2 m3] using reg2123_origen.xls, replace label  dec(2) alpha(0.001, 0.01, 0.05)


lrtest m1 m2, force
lrtest m2 m3, force

estimates stats m1 m2 m3 


coefplot (m1) (m2) (m3), keep(I_II:)  bylabel(I+II)   || ///
         (m1) (m2)(m3), keep(IIIab:) bylabel(IIIab) || ///
		  (m1) (m2)(m3), keep(IVabc:) bylabel(IVabc) || ///
		  (m1) (m2)(m3), keep(V_VI:) bylabel(V+VI) || ///
         , drop(_cons) xline(0)   baselevels     byopts(compact rows(1)) plotlabels("Model 1" "Model 2" "Model 3") 
		

		
**Supplementary material - robustness check - interaction term

mlogit clase5enccomb i.clase5oricomb i.sexocomb if edadcomb>=25 & oretfx2_comb!=. & omfcomb!=. & ENCUESTA!=2016, baseoutcome(5)
est sto m1
mlogit clase5enccomb i.clase5oricomb i.sexocomb i.omfcomb if edadcomb>=25 & oretfx2_comb!=. & ENCUESTA!=2016, baseoutcome(5)
est sto m2
mlogit clase5enccomb i.clase5oricomb i.sexocomb i.omfcomb ib2.oretfx2_comb if edadcomb>=25 & ENCUESTA!=2016, baseoutcome(5)
est sto m3
mlogit clase5enccomb i.educcomb i.clase5oricomb i.sexocomb i.omfcomb ib2.oretfx2_comb if edadcomb>=25 & ENCUESTA!=2016, baseoutcome(5)
est sto m4
mlogit clase5enccomb i.educcomb i.clase5oricomb i.sexocomb i.omfcomb ib2.oretfx2_comb i.omfcomb#ib2.oretfx2_comb if edadcomb>=25 & ENCUESTA!=2016, baseoutcome(5)
est sto m5


outreg2 [m1 m2 m3 m4 m5 ] using int2123_2_3.xls, replace see dec(3) label

lrtest m1 m2
lrtest m2 m3
lrtest m3 m4
lrtest m4 m5


estimates stats m1 m2 m3 m4 m5 


