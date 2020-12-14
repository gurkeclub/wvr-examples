vec2 rot(vec2 p, float r) {
  return vec2(cos(r) * p.x - sin(r) * p.y, sin(r) * p.x + cos(r) * p.y);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  vec2 cam_uv = vec2(1.0 - uv.x, uv.y);
  vec2 heart_uv =
      (1.0 + 0.1 * cos(iTime * PI / 2.0)) * rot(uv - 0.5, iTime / 16.0 * PI) +
      0.5;

  heart_uv = abs(fract(heart_uv) - 1.0);

  vec3 col = vec3(0.0);

  vec3 forest_col = texture(iChannel0, uv).rgb;
  vec3 cam_col = texture(iChannel1, cam_uv).rgb;
  vec3 hearts_col = texture(iChannel2, heart_uv).rgb;

  float sky_threshold = max(0.25, max(forest_col.r, forest_col.g) + 0.05);
  col = mix(forest_col, cam_col, step(sky_threshold, forest_col.b));
  col = mix(col, hearts_col,
            smoothstep(96.0 / 255.0, 128.0 / 255.0, hearts_col.r));


  fragColor = vec4(col, 1.0);
}
