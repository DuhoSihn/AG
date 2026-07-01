function acth = HSM_split( vars, act )
% Split, neural activities over hierarchy

L_inputs = length( vars.N_inputs );

acth = {};
for h = 1 : vars.L_hierarchy + 1
    for sh = 1 : L_inputs
        if h <= vars.L_sub_hierarchy + 1
            idx_units_h = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h ) == sh ), 2 );
            acth{ h, sh } = act( idx_units_h, : );
        else
            idx_units_h = any( vars.idx_modules( :, vars.idx_hierarchy( :, h ) ), 2 );
            acth{ h, 1 } = act( idx_units_h, : );
        end
    end
end
