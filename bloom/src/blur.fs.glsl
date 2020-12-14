

uniform bool horizontal;
uniform float weight[5] =
    float[](0.227027, 0.1945946, 0.1216216, 0.054054, 0.016216);

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;

  vec3 color = vec3(0.0);

  vec2 offset = vec2(1.33333333333) * vec2(float(horizontal), 1.0 - float(horizontal)) / iResolution.xy; 

  color += texture2D(iChannel0, uv).rgb * 0.29411764705882354;
  color += texture2D(iChannel0, uv + offset).rgb * 0.35294117647058826;
  color += texture2D(iChannel0, uv - offset).rgb * 0.35294117647058826;

  color *= 1.5;

  fragColor = vec4(color, 1.0);
}
