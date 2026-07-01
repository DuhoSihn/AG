function vars = HSM_initialize( vars )
% Initialize, Hierarchy of Supported Modules

L_inputs = length( vars.N_inputs );

if mod( vars.N_modules, L_inputs ) ~= 0, error( 'The length of "vars.N_inputs" must be able to divide "vars.N_modules"!' ), end
N_sub_modules = vars.N_modules / L_inputs;

if length( vars.C_bottom_up ) ~= L_inputs, error( 'The length of "vars.C_bottom_up" must be same to the length of "vars.N_inputs"!' ), end
if length( vars.C_top_down ) ~= L_inputs, error( 'The length of "vars.C_top_down" must be same to the length of "vars.N_inputs"!' ), end

if length( vars.L_memory ) ~= vars.L_hierarchy, error( 'The length of "vars.L_memory" must be same to "vars.L_hierarchy"!' ), end
L_max_memory = max( vars.L_memory );

N_units_ALL = sum( vars.N_inputs ) + ( vars.L_hierarchy * vars.N_modules * vars.N_units );
N_modules_ALL = L_inputs + ( vars.L_hierarchy * vars.N_modules );

% define, index for modules -----------------------------------------------
vars.idx_modules = false( N_units_ALL, N_modules_ALL );
ct_m = 0;
ct_u = 0;
for h = 1 : vars.L_hierarchy + 1
    if h == 1
        for m = 1 : L_inputs
            ct_m = ct_m + 1;
            vars.idx_modules( ct_u + [ 1 : vars.N_inputs( m ) ], ct_m ) = true;
            ct_u = ct_u + vars.N_inputs( m );
        end
    else
        for m = 1 : vars.N_modules
            ct_m = ct_m + 1;
            vars.idx_modules( ct_u + [ 1 : vars.N_units ], ct_m ) = true;
            ct_u = ct_u + vars.N_units;
        end
    end
end
% -------------------------------------------------------------------------

% define, index for hierarchy ---------------------------------------------
vars.idx_hierarchy = false( N_modules_ALL, vars.L_hierarchy + 1 );
ct_h = 0;
for h = 1 : vars.L_hierarchy + 1
    if h == 1
        vars.idx_hierarchy( 1 : L_inputs, h ) = true;
        ct_h = ct_h + L_inputs;
    else
        vars.idx_hierarchy( ct_h + [ 1 : vars.N_modules ], h ) = true;
        ct_h = ct_h + vars.N_modules;
    end
end
% -------------------------------------------------------------------------

% define, index for sub-hierarchy -----------------------------------------
vars.idx_sub_hierarchy = zeros( N_modules_ALL, vars.L_hierarchy + 1 );
ct_h = 0;
for h = 1 : vars.L_hierarchy + 1
    if h == 1
        for sh = 1 : L_inputs
            vars.idx_sub_hierarchy( ct_h + 1, h ) = sh;
            ct_h = ct_h + 1;
        end
    else
        for sh = 1 : L_inputs
            vars.idx_sub_hierarchy( ct_h + [ 1 : N_sub_modules ], h ) = sh;
            ct_h = ct_h + N_sub_modules;
        end
    end
end
% -------------------------------------------------------------------------

% initialize, synaptic weights for hierarchy ------------------------------
vars.w1 = nan( N_units_ALL, N_units_ALL );
for h = 1 : vars.L_hierarchy + 1
    if h == 1
        h1 = h;
        h2 = h + 1;
        for sh = 1 : L_inputs
            if h1 <= vars.L_sub_hierarchy + 1
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h1 ) == sh ), 2 );
            else
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h1 ) ), 2 );
            end
            if h2 <= vars.L_sub_hierarchy + 1
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h2 ) == sh ), 2 );
            else
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h2 ) ), 2 );
            end
            vars.w1( idx_units_h2, idx_units_h1 ) = rand( sum( idx_units_h2 ), sum( idx_units_h1 ) );
        end
        h1 = h + 1;
        h2 = h;
        for sh = 1 : L_inputs
            if h1 <= vars.L_sub_hierarchy + 1
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h1 ) == sh ), 2 );
            else
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h1 ) ), 2 );
            end
            if h2 <= vars.L_sub_hierarchy + 1
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h2 ) == sh ), 2 );
            else
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h2 ) ), 2 );
            end
            vars.w1( idx_units_h2, idx_units_h1 ) = rand( sum( idx_units_h2 ), sum( idx_units_h1 ) );
        end
    elseif h == vars.L_hierarchy + 1
        h1 = h;
        h2 = h - 1;
        for sh = 1 : L_inputs
            if h1 <= vars.L_sub_hierarchy + 1
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h1 ) == sh ), 2 );
            else
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h1 ) ), 2 );
            end
            if h2 <= vars.L_sub_hierarchy + 1
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h2 ) == sh ), 2 );
            else
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h2 ) ), 2 );
            end
            vars.w1( idx_units_h2, idx_units_h1 ) = rand( sum( idx_units_h2 ), sum( idx_units_h1 ) );
        end
    else
        h1 = h;
        h2 = h + 1;
        for sh = 1 : L_inputs
            if h1 <= vars.L_sub_hierarchy + 1
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h1 ) == sh ), 2 );
            else
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h1 ) ), 2 );
            end
            if h2 <= vars.L_sub_hierarchy + 1
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h2 ) == sh ), 2 );
            else
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h2 ) ), 2 );
            end
            vars.w1( idx_units_h2, idx_units_h1 ) = rand( sum( idx_units_h2 ), sum( idx_units_h1 ) );
        end
        h1 = h;
        h2 = h - 1;
        for sh = 1 : L_inputs
            if h1 <= vars.L_sub_hierarchy + 1
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h1 ) == sh ), 2 );
            else
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h1 ) ), 2 );
            end
            if h2 <= vars.L_sub_hierarchy + 1
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h2 ) == sh ), 2 );
            else
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h2 ) ), 2 );
            end
            vars.w1( idx_units_h2, idx_units_h1 ) = rand( sum( idx_units_h2 ), sum( idx_units_h1 ) );
        end
    end
end
% -------------------------------------------------------------------------

% initialize, synaptic weights for modules --------------------------------
vars.w2 = nan( N_units_ALL, L_max_memory * N_units_ALL );
for m = L_inputs + 1 : N_modules_ALL
    idx_units_m2 = vars.idx_modules( :, m );
    h = find( vars.idx_hierarchy( m, : ) ) - 1;
    idx_units_m1 = [ repmat( idx_units_m2, [ vars.L_memory( h ), 1 ] ); false( N_units_ALL * ( L_max_memory - vars.L_memory( h ) ), 1 ) ];
    vars.w2( idx_units_m2, idx_units_m1 ) = rand( sum( idx_units_m2 ), sum( idx_units_m1 ) );
end
% -------------------------------------------------------------------------

% synaptic scaling for hierarchy ------------------------------------------
for h = 1 : vars.L_hierarchy + 1
    if h == 1
        h1 = h;
        h2 = h + 1;
        for sh = 1 : L_inputs
            if h1 <= vars.L_sub_hierarchy + 1
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h1 ) == sh ), 2 );
            else
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h1 ) ), 2 );
            end
            if h2 <= vars.L_sub_hierarchy + 1
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h2 ) == sh ), 2 );
            else
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h2 ) ), 2 );
            end
            vars.w1( idx_units_h2, idx_units_h1 ) = vars.C_bottom_up( sh ) * vars.w1( idx_units_h2, idx_units_h1 ) ./ sum( vars.w1( idx_units_h2, idx_units_h1 ), 1 );% synaptic scaling
            vars.w1( idx_units_h2, idx_units_h1 ) = vars.C_bottom_up( sh ) * vars.w1( idx_units_h2, idx_units_h1 ) ./ sum( vars.w1( idx_units_h2, idx_units_h1 ), 2 );% synaptic scaling
        end
        h1 = h + 1;
        h2 = h;
        for sh = 1 : L_inputs
            if h1 <= vars.L_sub_hierarchy + 1
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h1 ) == sh ), 2 );
            else
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h1 ) ), 2 );
            end
            if h2 <= vars.L_sub_hierarchy + 1
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h2 ) == sh ), 2 );
            else
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h2 ) ), 2 );
            end
            vars.w1( idx_units_h2, idx_units_h1 ) = vars.C_top_down( sh ) * vars.w1( idx_units_h2, idx_units_h1 ) ./ sum( vars.w1( idx_units_h2, idx_units_h1 ), 1 );% synaptic scaling
            vars.w1( idx_units_h2, idx_units_h1 ) = vars.C_top_down( sh ) * vars.w1( idx_units_h2, idx_units_h1 ) ./ sum( vars.w1( idx_units_h2, idx_units_h1 ), 2 );% synaptic scaling
        end
    elseif h == vars.L_hierarchy + 1
        h1 = h;
        h2 = h - 1;
        for sh = 1 : L_inputs
            if h1 <= vars.L_sub_hierarchy + 1
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h1 ) == sh ), 2 );
            else
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h1 ) ), 2 );
            end
            if h2 <= vars.L_sub_hierarchy + 1
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h2 ) == sh ), 2 );
            else
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h2 ) ), 2 );
            end
            vars.w1( idx_units_h2, idx_units_h1 ) = vars.C_top_down( sh ) * vars.w1( idx_units_h2, idx_units_h1 ) ./ sum( vars.w1( idx_units_h2, idx_units_h1 ), 1 );% synaptic scaling
            vars.w1( idx_units_h2, idx_units_h1 ) = vars.C_top_down( sh ) * vars.w1( idx_units_h2, idx_units_h1 ) ./ sum( vars.w1( idx_units_h2, idx_units_h1 ), 2 );% synaptic scaling
        end
    else
        h1 = h;
        h2 = h + 1;
        for sh = 1 : L_inputs
            if h1 <= vars.L_sub_hierarchy + 1
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h1 ) == sh ), 2 );
            else
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h1 ) ), 2 );
            end
            if h2 <= vars.L_sub_hierarchy + 1
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h2 ) == sh ), 2 );
            else
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h2 ) ), 2 );
            end
            vars.w1( idx_units_h2, idx_units_h1 ) = vars.C_bottom_up( sh ) * vars.w1( idx_units_h2, idx_units_h1 ) ./ sum( vars.w1( idx_units_h2, idx_units_h1 ), 1 );% synaptic scaling
            vars.w1( idx_units_h2, idx_units_h1 ) = vars.C_bottom_up( sh ) * vars.w1( idx_units_h2, idx_units_h1 ) ./ sum( vars.w1( idx_units_h2, idx_units_h1 ), 2 );% synaptic scaling
        end
        h1 = h;
        h2 = h - 1;
        for sh = 1 : L_inputs
            if h1 <= vars.L_sub_hierarchy + 1
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h1 ) == sh ), 2 );
            else
                idx_units_h1 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h1 ) ), 2 );
            end
            if h2 <= vars.L_sub_hierarchy + 1
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_sub_hierarchy( :, h2 ) == sh ), 2 );
            else
                idx_units_h2 = any( vars.idx_modules( :, vars.idx_hierarchy( :, h2 ) ), 2 );
            end
            vars.w1( idx_units_h2, idx_units_h1 ) = vars.C_top_down( sh ) * vars.w1( idx_units_h2, idx_units_h1 ) ./ sum( vars.w1( idx_units_h2, idx_units_h1 ), 1 );% synaptic scaling
            vars.w1( idx_units_h2, idx_units_h1 ) = vars.C_top_down( sh ) * vars.w1( idx_units_h2, idx_units_h1 ) ./ sum( vars.w1( idx_units_h2, idx_units_h1 ), 2 );% synaptic scaling
        end
    end
end
% -------------------------------------------------------------------------

% synaptic scaling for modules --------------------------------------------
for m = L_inputs + 1 : N_modules_ALL
    idx_units_m2 = vars.idx_modules( :, m );
    h = find( vars.idx_hierarchy( m, : ) ) - 1;
    idx_units_m1 = [ repmat( idx_units_m2, [ vars.L_memory( h ), 1 ] ); false( N_units_ALL * ( L_max_memory - vars.L_memory( h ) ), 1 ) ];
    vars.w2( idx_units_m2, idx_units_m1 ) = vars.w2( idx_units_m2, idx_units_m1 ) ./ sum( vars.w2( idx_units_m2, idx_units_m1 ), 1 );% synaptic scaling
    vars.w2( idx_units_m2, idx_units_m1 ) = vars.w2( idx_units_m2, idx_units_m1 ) ./ sum( vars.w2( idx_units_m2, idx_units_m1 ), 2 );% synaptic scaling
end
% -------------------------------------------------------------------------

% initialize, time-series of neural activity ------------------------------
vars.xn = ones( N_units_ALL, L_max_memory );
% -------------------------------------------------------------------------
