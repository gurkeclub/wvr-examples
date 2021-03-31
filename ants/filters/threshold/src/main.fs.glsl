uniform bool MIRROR;
uniform bool THRESHOLD_REVERSE;
uniform float THRESHOLD;
uniform float THRESHOLD_SLOPE;

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;
    if (MIRROR) {
        uv.x = 1.0 - uv.x;
    }

    vec3 color = texture(iChannel0, uv).rgb;
    
    float is_peak = smoothstep(0.0, THRESHOLD_SLOPE, length(color) - THRESHOLD);
    
    if (THRESHOLD_REVERSE) {
        is_peak = 1.0 - is_peak;
    }

    /*
    is_peak = 0.0;
    uv = (uv * 2.0 - 1.0) * iResolution.xy / iResolution.yy;

    is_peak = max(is_peak, step(0.0, 0.1 - distance(uv, vec2(0.5, 0.0))));
    is_peak = max(is_peak, step(0.0, 0.1 - distance(uv, vec2(-0.5, 0.0))));
    */
    
    color = vec3(is_peak);
    
    fragColor = vec4(color,1.0);
}
