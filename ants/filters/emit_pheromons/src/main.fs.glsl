in float ant_pheromons;


uniform float ANT_SIZE;
uniform int ANT_COUNT;


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord/iResolution.xy;

    uv -= 0.5;

    float pheromon_intensity =  ant_pheromons * smoothstep(0.0, 0.05, 0.5 - length(uv) - 0.05 );


    
    fragColor = vec4(vec3(pheromon_intensity), 1.0);
}
