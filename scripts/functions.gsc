
function get_lookat_origin( player )
{
    angles = player getplayerangles();
    forward = anglestoforward( angles );
    dir = vectorscale( forward, 8000 );
    eye = player geteye();
    trace = bullettrace( eye, eye + dir, 0, undefined );
    return trace[ #"position" ];
}