uniform float DIFFUSE_DECAY;
uniform float INTEGRATE_DECAY;

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord/iResolution.xy;
    float pheromons_diffusion = 0.0;
    float pheromons_integration = texture(iChannel1, uv).g;
    
    for (int x = -1; x<=1; x++) {
        for (int y = -1; y<=1; y++) {
        	vec2 peeking_pos = fract(uv + vec2(float(x) * 1.5, float(y) * 1.5) / iResolution.xy);
            pheromons_diffusion += texture(iChannel1, peeking_pos).r;
        }
    }
    pheromons_diffusion /= 9.0;
    pheromons_diffusion = max(texture(iChannel0, uv).r, pheromons_diffusion - DIFFUSE_DECAY);
    
    
    
    pheromons_diffusion = clamp(pheromons_diffusion - DIFFUSE_DECAY, 0.0, 8.0);
    
    pheromons_integration = max(pheromons_integration - INTEGRATE_DECAY, pheromons_diffusion) ;
    
    pheromons_integration = clamp(pheromons_integration, 0.0, 8.0);
    
    fragColor = vec4(pheromons_diffusion, pheromons_integration, texture(iChannel0, uv).g,1.0);
}
