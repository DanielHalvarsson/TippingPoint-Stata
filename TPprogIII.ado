* Program for locating the roots of a p-th order polynomial and evaluate the derivatives

capture program drop tproot
mata: mata clear

program tproot
	version 16
    mata: b = st_matrix("xcoeff"); B = b[1,5],b[1,1..4]; realroots(B)
	*display as txt " Tipping point = "
    *mat list Root
		
	mata: C = b[1,1..4]; Root = st_matrix("Root"); polyderive(Root, C)
	*display as txt " Derivative "
    *mat list dydx
	
    mata: output()

end

mata:
void output()
{
Root = st_matrix("Root")
dydx = st_matrix("dydx")
	if (length(Root)==0){
		tp = J(1,1,.) 
		st_matrix("e(tp)", tp)
	}
	else {
		tp = sort((Root',dydx),2)
		st_matrix("e(tp)", tp)
	}
}
end
* this is a test 1

mata:
real matrix	function polyderive(real vector X, real rowvector C)
	{    
	real scalar  n
	real vector A, dydx
	n = length(X)
	A = (J(n,1,1), 2*(X'), 3*(X':^2), 4*(X':^3))
	dydx = A*C'
	st_matrix("dydx", dydx)
	}
end
	
mata:
real matrix function realroots(real vector B)
{
real rowvector Root
Poly = polyroots(B)
PolyReal1 = select(Poly, Re(Poly):>0)
PolyReal2 = select(PolyReal1, Re(PolyReal1):<60)
if (length(PolyReal2)==0){
		Root = J(1,1,.) 
		st_matrix("Root", Root)
	}
	else {
		Root = Re(select(PolyReal2, Im(PolyReal2):==0))
		st_matrix("Root", Root)
	}
}
end





**********************************************************************************************************************************************************