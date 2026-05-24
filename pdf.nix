{ pkgs, ... }:

{
  # ============================================================================
  # PDF & DOCUMENT CONFIGURATION
  # ============================================================================
  # Installs PDF readers, editors, converters, and OCR tools
  # ============================================================================

  environment.systemPackages = with pkgs; [
    # PDF viewers
    zathura
    evince

    # PDF editing & manipulation
    pdfarranger
    poppler_utils
    qpdf

    # Document conversion
    pandoc

    # OCR
    tesseract
  ];
}
