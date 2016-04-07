
create or replace function detfacfunc(varchar[])
declare
  det_facility varchar[];
  city varchar[] := string_to_array
begin 
foreach det_facility slice 1 in array city
loop
    select det_facility,
    lift_reason,
    count(*)
    from requests
    where det_facility
    like '${facility}'
    and lift_reason
    is not null
    group by lift_reason, det_facility
    order by count desc;
  end loop;
  return;
end;
