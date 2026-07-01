function [ vars, act ] = HSM_process_GPU( vars, data )
% Process, Hierarchy of Supported Modules
%
% data : inputs, (channel) X (time) form.
%
% act : neural activities, (unit) X (time) form.

% -------------------------------------------------------------------------
vars.N_units = gpuArray( vars.N_units );
vars.C_bottom_up = gpuArray( vars.C_bottom_up );
vars.C_top_down = gpuArray( vars.C_top_down );
vars.C_activation = gpuArray( vars.C_activation );
vars.C_activation_input = gpuArray( vars.C_activation_input );
vars.C_activation_threshold = gpuArray( vars.C_activation_threshold );
vars.C_adaptation_unit = gpuArray( vars.C_adaptation_unit );
vars.C_adaptation_module = gpuArray( vars.C_adaptation_module );
vars.C_recurrent_unit = gpuArray( vars.C_recurrent_unit );
vars.C_recurrent_module = gpuArray( vars.C_recurrent_module );
vars.idx_modules = gpuArray( vars.idx_modules );
vars.w1 = gpuArray( vars.w1 );
vars.w2 = gpuArray( vars.w2 );
vars.xn = gpuArray( vars.xn );
vars.learning_assign = gpuArray( vars.learning_assign );
vars.learning_threshold = gpuArray( vars.learning_threshold );
vars.learning_rate = gpuArray( vars.learning_rate );
vars.learning_stereotyped = gpuArray( vars.learning_stereotyped );
data = gpuArray( data );
% -------------------------------------------------------------------------

if length( vars.C_activation ) ~= vars.L_hierarchy, error( 'The length of "vars.C_activation" must be same to "vars.L_hierarchy"!' ), end

L_inputs = length( vars.N_inputs );

L_max_memory = max( vars.L_memory );

L_max_adaptation_unit = max( vars.L_adaptation_unit );
L_max_adaptation_module = max( vars.L_adaptation_module );

L_max_recurrent_unit = max( vars.L_recurrent_unit );
L_max_recurrent_module = max( vars.L_recurrent_module );

N_units_ALL = sum( vars.N_inputs ) + ( vars.L_hierarchy * vars.N_modules * vars.N_units );
N_modules_ALL = L_inputs + ( vars.L_hierarchy * vars.N_modules );

N_units_inputs = sum( vars.N_inputs );

if size( data, 1 ) ~= N_units_inputs, error( 'The sum of "vars.N_inputs" must be same to the 1st dimension of "data"!' ), end
T_data = size( data, 2 );

a1 = nan( N_units_ALL, 1 );
a2 = nan( N_units_ALL, 1 );
a = nan( N_modules_ALL, 1 );
for h = 1 : vars.L_hierarchy + 1
    idx_units_h = any( vars.idx_modules( :, vars.idx_hierarchy( :, h ) ), 2 );
    idx_modules_h = vars.idx_hierarchy( :, h );
    if h == 1
        a1( idx_units_h ) = vars.C_activation_input;
        a2( idx_units_h ) = vars.C_activation_input;
        a( idx_modules_h ) = vars.C_activation_input;
    else
        a1( idx_units_h ) = vars.C_activation( h - 1 );
        a2( idx_units_h ) = vars.C_activation( h - 1 );
        a( idx_modules_h ) = vars.C_activation( h - 1 );
    end
end

dn = nan( N_units_ALL, L_max_adaptation_unit );
for h = 1 : vars.L_hierarchy + 1
    idx_units_h = any( vars.idx_modules( :, vars.idx_hierarchy( :, h ) ), 2 );
    if h == 1
    else
        dn( idx_units_h, 1 : vars.L_adaptation_unit( h - 1 ) ) = 1;
    end
end

dnb = nan( N_modules_ALL, L_max_adaptation_unit );
for h = 1 : vars.L_hierarchy + 1
    idx_modules_h = vars.idx_hierarchy( :, h );
    if h == 1
    else
        dnb( idx_modules_h, 1 : vars.L_adaptation_module( h - 1 ) ) = 1;
    end
end

rn = nan( N_units_ALL, L_max_recurrent_unit );
for h = 1 : vars.L_hierarchy + 1
    idx_units_h = any( vars.idx_modules( :, vars.idx_hierarchy( :, h ) ), 2 );
    if h == 1
    else
        rn( idx_units_h, 1 : vars.L_recurrent_unit( h - 1 ) ) = repmat( linspace( 1, 1 ./ vars.L_recurrent_unit( h - 1 ), vars.L_recurrent_unit( h - 1 ) ), [ sum( idx_units_h ), 1 ] );
        rn( idx_units_h, : ) = rn( idx_units_h, : ) ./ sum( rn( idx_units_h, : ), 2, 'omitnan' );
    end
end

rnb = nan( N_modules_ALL, L_max_recurrent_unit );
for h = 1 : vars.L_hierarchy + 1
    idx_modules_h = vars.idx_hierarchy( :, h );
    if h == 1
    else
        rnb( idx_modules_h, 1 : vars.L_recurrent_module( h - 1 ) ) = repmat( linspace( 1, 1 ./ vars.L_recurrent_module( h - 1 ), vars.L_recurrent_module( h - 1 ) ), [ sum( idx_modules_h ), 1 ] );
        rnb( idx_modules_h, : ) = rnb( idx_modules_h, : ) ./ sum( rnb( idx_modules_h, : ), 2, 'omitnan' );
    end
end

xnd = ones( N_units_ALL, L_max_adaptation_unit );

xnr = ones( N_units_ALL, L_max_recurrent_unit );

bnd = nan( N_modules_ALL, L_max_adaptation_module );

bnr = nan( N_modules_ALL, L_max_recurrent_module );

thr_b_module = vars.C_adaptation_module( 1 ) .* ( vars.idx_hierarchy * transpose( [ vars.C_activation_input, vars.C_activation ] ) );

if strcmpi( vars.learning, 'assign' ) && length( vars.learning_assign ) ~= size( data, 2 ), error( 'The length of "vars.learning_assign" must be same to the number of time points in "data"!' ), end

ct_learning = 0;
act = nan( N_units_ALL, T_data );
xn_learning = nan( N_units_ALL, vars.learning_scaling );
% -------------------------------------------------------------------------
a1 = gpuArray( a1 );
a2 = gpuArray( a2 );
a = gpuArray( a );
dn = gpuArray( dn );
dnb = gpuArray( dnb );
rn = gpuArray( rn );
rnb = gpuArray( rnb );
xnd = gpuArray( xnd );
xnr = gpuArray( xnr );
bnd = gpuArray( bnd );
bnr = gpuArray( bnr );
thr_b_module = gpuArray( thr_b_module );
act = gpuArray( act );
xn_learning = gpuArray( xn_learning );
% -------------------------------------------------------------------------
for t = 1 : T_data

    % -------------------------------------------------------------------------

    x1 = vars.xn( :, 1 );
    x2 = vars.xn( : );

    x1( 1 : N_units_inputs ) = data( :, t );
    x2( 1 : N_units_inputs ) = data( :, t );

    xx1 = sum( vars.w1 .* transpose( x1 ), 2, 'omitnan' );
    xx2 = sum( vars.w2 .* transpose( x2 ), 2, 'omitnan' );

    % -------------------------------------------------------------------------

    y1 = xx1;
    y2 = xx2;

    y2( 1 : N_units_inputs ) = 1;

    y1 = log( y1 );
    y2 = log( y2 );

    % y = y - mean( y, 'omitnan' )
    y1 = y1 - vars.idx_modules * transpose( sum( y1 .* vars.idx_modules, 1, 'omitnan' ) / vars.N_units );
    y2 = y2 - vars.idx_modules * transpose( sum( y2 .* vars.idx_modules, 1, 'omitnan' ) / vars.N_units );
    myi = vars.idx_modules( :, 1 : L_inputs ) * transpose( sum( y1 .* vars.idx_modules( :, 1 : L_inputs ), 1, 'omitnan' ) ./ vars.N_inputs );
    y1( 1 : N_units_inputs ) = y1( 1 : N_units_inputs ) - myi( 1 : N_units_inputs );

    % b = mean( abs( y ), 'omitnan' )
    b1 = vars.idx_modules * transpose( sum( abs( y1 ) .* vars.idx_modules, 1, 'omitnan' ) / vars.N_units );
    b2 = vars.idx_modules * transpose( sum( abs( y2 ) .* vars.idx_modules, 1, 'omitnan' ) / vars.N_units );
    mb1i = vars.idx_modules( :, 1 : L_inputs ) * transpose( sum( abs( y1 ) .* vars.idx_modules( :, 1 : L_inputs ), 1, 'omitnan' ) ./ vars.N_inputs );
    b1( 1 : N_units_inputs ) = mb1i( 1 : N_units_inputs );

    b2( 1 : N_units_inputs ) = 1;

    y1 = ( a1 ./ b1 ) .* y1;
    y2 = ( a2 ./ b2 ) .* y2;

    y1 = exp( y1 );
    y2 = exp( y2 );

    % y = y / mean( y, 'omitnan' );
    y1 = y1 ./ ( vars.idx_modules * transpose( sum( y1 .* vars.idx_modules, 1, 'omitnan' ) / vars.N_units ) );
    y2 = y2 ./ ( vars.idx_modules * transpose( sum( y2 .* vars.idx_modules, 1, 'omitnan' ) / vars.N_units ) );
    myi = vars.idx_modules( :, 1 : L_inputs ) * transpose( sum( y1 .* vars.idx_modules( :, 1 : L_inputs ), 1, 'omitnan' ) ./ vars.N_inputs );
    y1( 1 : N_units_inputs ) = y1( 1 : N_units_inputs ) ./ myi( 1 : N_units_inputs );
    % y1( 1 : N_units_inputs ) = y1( 1 : N_units_inputs ) ./ mean( y1( 1 : N_units_inputs ), 1, 'omitnan' );

    % -------------------------------------------------------------------------

    y = y1 + y2;

    % -------------------------------------------------------------------------

    y = log( y );

    % y = y - mean( y, 'omitnan' )
    y = y - vars.idx_modules * transpose( sum( y .* vars.idx_modules, 1, 'omitnan' ) / vars.N_units );
    myi = vars.idx_modules( :, 1 : L_inputs ) * transpose( sum( y .* vars.idx_modules( :, 1 : L_inputs ), 1, 'omitnan' ) ./ vars.N_inputs );
    y( 1 : N_units_inputs ) = y( 1 : N_units_inputs ) - myi( 1 : N_units_inputs );

    % b = mean( abs( y ), 'omitnan' ) within modules set
    b = transpose( sum( abs( y ) .* vars.idx_modules, 1, 'omitnan' ) / vars.N_units );
    mbi = transpose( sum( abs( y ) .* vars.idx_modules( :, 1 : L_inputs ), 1, 'omitnan' ) ./ vars.N_inputs );
    b( 1 : L_inputs ) = mbi( 1 : L_inputs );

    r_b = sum( rnb .* bnr, 2, 'omitnan' );
    r_b( 1 : L_inputs ) = b( 1 : L_inputs );
    b = ( 1 - vars.C_recurrent_module ) .* b + ( vars.C_recurrent_module ) .* r_b;

    d_b = mean( dnb .* ( bnd > thr_b_module ), 2, 'omitnan' );
    d_b( 1 : L_inputs ) = 0;
    b( d_b >= vars.C_adaptation_module( 2 ) ) = thr_b_module( d_b >= vars.C_adaptation_module( 2 ) );

    bnd( :, 2 : end ) = bnd( :, 1 : end - 1 );
    bnd( :, 1 ) = b;

    bnr( :, 2 : end ) = bnr( :, 1 : end - 1 );
    bnr( :, 1 ) = b;

    ab = vars.C_activation_input .* ones( N_modules_ALL, 1 );
    for h = 2 : vars.L_hierarchy + 1
        for sh = 1 : L_inputs
            if h <= vars.L_sub_hierarchy + 1
                idx_modules_h = vars.idx_sub_hierarchy( :, h ) == sh;
            else
                idx_modules_h = vars.idx_hierarchy( :, h );
            end
            by = b( idx_modules_h );
            by = log( by );
            by = by - mean( by, 1, 'omitnan' );
            bb = mean( abs( by ), 1, 'omitnan' );
            by = ( a( idx_modules_h ) ./ bb ) .* by;
            by = exp( by );
            by = by / mean( by, 1, 'omitnan' );
            ab( idx_modules_h, 1 ) = by;
        end
    end

    % b = mean( abs( y ), 'omitnan' )
    b = vars.idx_modules * b;
    ab = vars.idx_modules * ab;
    
    ab( ab > vars.C_activation_threshold ) = vars.C_activation_threshold;

    y = ( ab ./ b ) .* y;

    y = exp( y );

    % y = y / mean( y, 'omitnan' );
    y = y ./ ( vars.idx_modules * transpose( sum( y .* vars.idx_modules, 1, 'omitnan' ) / vars.N_units ) );
    myi = vars.idx_modules( :, 1 : L_inputs ) * transpose( sum( y .* vars.idx_modules( :, 1 : L_inputs ), 1, 'omitnan' ) ./ vars.N_inputs );
    y( 1 : N_units_inputs ) = y( 1 : N_units_inputs ) ./ myi( 1 : N_units_inputs );

    % -------------------------------------------------------------------------

    r = sum( rn .* xnr, 2, 'omitnan' );
    r( 1 : N_units_inputs ) = y( 1 : N_units_inputs );
    y = ( 1 - vars.C_recurrent_unit ) .* y + ( vars.C_recurrent_unit ) .* r;

    d = mean( dn .* ( xnd > vars.C_adaptation_unit( 1 ) ), 2, 'omitnan' );
    d( 1 : N_units_inputs ) = 0;
    y( d >= vars.C_adaptation_unit( 2 ) ) = 1;

    vars.xn( :, 2 : end ) = vars.xn( :, 1 : end - 1 );
    vars.xn( :, 1 ) = y;

    xnd( :, 2 : end ) = xnd( :, 1 : end - 1 );
    xnd( :, 1 ) = y;

    xnr( :, 2 : end ) = xnr( :, 1 : end - 1 );
    xnr( :, 1 ) = y;

    act( :, t ) = vars.xn( :, 1 );

    % -------------------------------------------------------------------------

    if strcmpi( vars.learning, 'on' ) || ( strcmpi( vars.learning, 'assign' ) && vars.learning_assign( t ) == 1 )

        ct_learning = ct_learning + 1;
        xn_learning( :, ct_learning ) = vars.xn( :, 1 );

        % -------------------------------------------------------------------------

        z = vars.xn( :, 1 );

        % -------------------------------------------------------------------------

        x0 = x1;
        z0 = z;

        x0( ~any( vars.idx_modules( :, vars.idx_hierarchy( :, 1 ) ), 2 ) ) = 0;
        z0( ~any( vars.idx_modules( :, vars.idx_hierarchy( :, 2 ) ), 2 ) ) = 0;

        idxL_z0 = z0 < vars.learning_threshold;

        z0( idxL_z0 ) = 0;
        
        % z0( ~idxL_z0 ) = 1;

        x0 = sqrt( x0 );
        z0 = sqrt( z0 );

        vars.w1 = vars.w1 + vars.learning_rate .* ( x0 .* transpose( z0 ) );

        % -------------------------------------------------------------------------

        idxL_x1 = x1 < vars.learning_threshold;
        idxL_x2 = x2 < vars.learning_threshold;
        idxL_z = z < vars.learning_threshold;

        x1( idxL_x1 ) = 0;
        x2( idxL_x2 ) = 0;
        z( idxL_z ) = 0;

        % x1( ~idxL_x1 ) = 1;
        % x2( ~idxL_x2 ) = 1;
        % z( ~idxL_z ) = 1;

        x1( 1 : N_units_inputs ) = 0;
        x2( 1 : N_units_inputs ) = 0;
        z( 1 : N_units_inputs ) = 0;

        x1 = sqrt( x1 );
        x2 = sqrt( x2 );
        z = sqrt( z );

        vars.w1 = vars.w1 + vars.learning_rate .* ( z .* transpose( x1 ) );
        vars.w2 = vars.w2 + vars.learning_rate .* ( z .* transpose( x2 ) );

        % -------------------------------------------------------------------------

        if ct_learning == vars.learning_scaling

            ct_learning = 0;

            % synaptic re-scaling to prevent stereotyped behavior ---------------------
            idx_units_stereotyped = mean( xn_learning, 2, 'omitnan' ) > vars.learning_stereotyped( 1 );
            vars.w1( idx_units_stereotyped, idx_units_stereotyped ) = vars.learning_stereotyped( 2 ) .* vars.w1( idx_units_stereotyped, idx_units_stereotyped );
            vars.w2( idx_units_stereotyped, repmat( idx_units_stereotyped, [ L_max_memory, 1 ] ) ) = vars.learning_stereotyped( 2 ) .* vars.w2( idx_units_stereotyped, repmat( idx_units_stereotyped, [ max( vars.L_memory ), 1 ] ) );
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

        end

    end

end

% -------------------------------------------------------------------------
vars.N_units = gather( vars.N_units );
vars.C_bottom_up = gather( vars.C_bottom_up );
vars.C_top_down = gather( vars.C_top_down );
vars.C_activation = gather( vars.C_activation );
vars.C_activation_input = gather( vars.C_activation_input );
vars.C_activation_threshold = gather( vars.C_activation_threshold );
vars.C_adaptation_unit = gather( vars.C_adaptation_unit );
vars.C_adaptation_module = gather( vars.C_adaptation_module );
vars.C_recurrent_unit = gather( vars.C_recurrent_unit );
vars.C_recurrent_module = gather( vars.C_recurrent_module );
vars.idx_modules = gather( vars.idx_modules );
vars.w1 = gather( vars.w1 );
vars.w2 = gather( vars.w2 );
vars.xn = gather( vars.xn );
vars.learning_assign = gather( vars.learning_assign );
vars.learning_threshold = gather( vars.learning_threshold );
vars.learning_rate = gather( vars.learning_rate );
vars.learning_stereotyped = gather( vars.learning_stereotyped );
act = gather( act );
% -------------------------------------------------------------------------
