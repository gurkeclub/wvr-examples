uniform float DOT_RADIUS;

uniform float BEAT_SYNC;
uniform float BEAT_EFFECT;

uniform float BORDER_EFFECT;


vec2 rot(vec2 p, float r) {
    return vec2(
        p.x * cos(r) - p.y * sin(r),
        p.y * cos(r) + p.x * sin(r)
    );
}


vec3 scene_color(vec2 uv) {
    vec2 interval = vec2(DOT_RADIUS);
    
    // time varying density
    interval *= (1.0 - BEAT_EFFECT * cos(iBeat * BEAT_SYNC * PI));
    
    // border effect
    interval *= (1.0 + BORDER_EFFECT * smoothstep(0.0, 0.25, max(abs(uv.x - 0.5), abs(uv.y - 0.5)) - 0.375) );
    
    // computation of the closest dot center;
    vec2 ref = uv - 0.5;
    ref = floor(ref * iResolution.xy / interval + 0.5) * interval / iResolution.xy;
    ref += 0.5;
    
    // initial value set to 1.0 as we're doing substractive coloring
    vec3 value = vec3(1.0);
    
    // substraction of the neighbour ink dots
    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) { 
            // Currently considered ink dot center point
            vec2 center = ref + vec2(x, y) * interval / iResolution.xy;
            
            // Distance to the ink dot center
            float center_distance = length((uv - center) / (interval / iResolution.xy));
            
            // Color intensity for the ink dot
            vec3 intensity = texture(iChannel0, center).rgb;
            
            // radius of the dot for each of the color components
            vec3 radius = (1.0 - intensity) / 2.0 * sqrt(2.0);
            
            // Substraction of each color component for the currently considered ink dot
            value = min(value, smoothstep(0.0, 1.0 / interval.x,  center_distance - radius));
        }
    }
    
    return vec3(value);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;

    vec3 col = scene_color(vec2(1.0 - uv.x, uv.y));

    fragColor = vec4(col,1.0);
}