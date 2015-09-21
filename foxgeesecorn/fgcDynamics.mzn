predicate fgcDynamics(array[int, int] of var int: statusUnchanged, array[int, int] of var int: status, int: t, array[int] of var int: transported) =
    if sum([bool2int(statusUnchanged[t,i] > 0) | i in 1..3]) < 2 \/ transported[t] = 0 then
            status[t,1] = statusUnchanged[t,1] /\
            status[t,2] = statusUnchanged[t,2] /\
            status[t,3] = statusUnchanged[t,3]
    elseif statusUnchanged[t,2] = 0 then
            status[t,1] = statusUnchanged[t,1] - 1 /\
            status[t,2] = statusUnchanged[t,2] /\
            status[t,3] = statusUnchanged[t,3] - 1
    elseif statusUnchanged[t,1] = 0 /\ statusUnchanged[t,2] > statusUnchanged[t,3] then
            status[t,1] = statusUnchanged[t,1] /\
            status[t,2] = statusUnchanged[t,2] - 1 /\
            status[t,3] = statusUnchanged[t,3] - 1
    elseif statusUnchanged[t,1] = 0 /\ statusUnchanged[t,2] <= statusUnchanged[t,3] then
            status[t,1] = statusUnchanged[t,1] /\
            status[t,3] = statusUnchanged[t,3] - statusUnchanged[t,2] /\
            status[t,2] = statusUnchanged[t,2]
    elseif statusUnchanged[t, 1] > statusUnchanged[t,2] then
            status[t,1] = statusUnchanged[t,1] - 1 /\
            status[t,2] = statusUnchanged[t,2] /\
            status[t,3] = statusUnchanged[t,3]
    else status[t,1] = statusUnchanged[t,1] /\
          status[t,2] = statusUnchanged[t,2] - statusUnchanged[t,1] /\
          status[t,3] = statusUnchanged[t,3]

    endif;
