uniform float DOT_SIZE;
uniform float DOT_INTERVAL;

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord/iResolution.xy;

    vec3 color = vec3(0.0);
    
    float is_peak = 0.0;
    

    
    is_peak = 0.0;
    uv = (uv * 2.0 - 1.0) * iResolution.xy / iResolution.yy;

    is_peak = max(is_peak, step(0.0, 0.1 - distance(uv, vec2(0.5, 0.0))));
    is_peak = max(is_peak, step(0.0, 0.1 - distance(uv, vec2(-0.5, 0.0))));
    
    
    color = vec3(is_peak);
    
    fragColor = vec4(color,1.0);
}
