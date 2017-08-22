SELECT state, SchoolDistrict, Gender, EducationDefined, salary 
from salaries s inner join schooldistricts d
			on s.DistrictID = d.DistrictID
inner join gender g
            on s.GenderID = g.GenderID
inner join education e
			on s.EducationID = e.EducationID
inner join states st 
			on d.StateID = st.StateID


;