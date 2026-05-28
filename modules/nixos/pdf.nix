# ============================================================================
# MODULE: pdf
# CATEGORY: system
# VERSION: 1.0.0
# TAGS: pdf document viewer ocr
# DEPS: none
# INFO: PDF readers, editors, converters, and OCR tools
# ============================================================================
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zathura evince pdfarranger poppler_utils qpdf pandoc tesseract
  ];
}
