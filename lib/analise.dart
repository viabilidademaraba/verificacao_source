bool resultado(Map data) {
  if (resultadoZona(data[4]).contains("não")) {
    return false;
  }
  if (resultadoUso(data[4], data[6], data[2]).contains("não")) {
    return false;
  }
  if (getCotaAltimetrica(double.parse(data[12]))[0] == false) {
    return false;
  }
  if (getCoeficienteAproveitamento(
          double.parse(data[13]), data[5], data["option1"])[0] ==
      false) {
    return false;
  }
  if (getTaxaOcupacao(double.parse(data[14]), data[3], data[6], data[2])[0] ==
      false) {
    return false;
  }
  if (getTaxaPermeabilidade(double.parse(data[15]))[0] == false) {
    return false;
  }
  if (getRecuoFrontal(double.parse(data[16]), data[3], data[6], data[2])[0] ==
      false) {
    return false;
  }
  if (getRecuoFundo(double.parse(data[17]), data[3], data[6], data[2])[0] ==
      false) {
    return false;
  }
  if (getRecuoLateralDireita(
          double.parse(data[18]), data[3], data[6], data[2])[0] ==
      false) {
    return false;
  }
  if (getRecuoLateralEsquerda(double.parse(data[19]), data[6])[0] == false) {
    return false;
  }
  if (getRecuoLateralEsquina(
          double.parse(data[20]), data[3], data[6], data[2])[0] ==
      false) {
    return false;
  }
  if (getAlturaEdificacao(double.parse(data[21]), double.parse(data[23]),
          double.parse(data[16]))[0] ==
      false) {
    return false;
  }
  if (getLarguraFrente(double.parse(data[22]), data[3], data[6], data[2])[0] ==
      false) {
    return false;
  }

  return true;
}

String resultadoZona(String entrada) {
  if (entrada == "Zona Especial de Interesse Ambiental" ||
      entrada == "Zona de Segurança do Aeroporto") {
    return "$entrada, não sendo permitida a localização";
  }
  return "$entrada, sendo permitida a localização";
}

String resultadoUso(String zona, String uso, String localizacao) {
  if (zona == "Zona Especial Industrial" &&
      (uso == "Residencial Unifamiliar" ||
          uso == "Residencial Multifamiliar" ||
          uso == "Misto")) {
    return "$uso, não sendo permitido o uso do solo na localização.";
  }

  if (uso == "Industrial" && zona != "Zona Especial Industrial") {
    return "$uso, não sendo permitido o uso do solo na localização.";
  }

  if (uso == "Rural" && localizacao != "Zona Rural, fora de uma Vila Sede") {
    return "$uso, não sendo permitido o uso do solo na localização.";
  }

  if (zona == "Zona Especial de Interesse Ambiental") {
    return "$uso, não sendo permitido o uso do solo na localização.";
  }

  if (zona == "Zona de Segurança do Aeroporto") {
    return "$uso, não sendo permitido o uso do solo na localização.";
  }

  return "$uso, sendo permitido o uso do solo na localização.";
}

String getGrauIncomodidade(String entrada) {
  if (entrada == "Grau 1 - Baixíssimo") return "1";
  if (entrada == "Grau 2 - Baixo") return "2";
  if (entrada == "Grau 3 - Médio") return "3";
  if (entrada == "Grau 4 - Alto") return "4";
  if (entrada == "Grau 5 - Altíssimo") return "5";
  return "";
}

String getLocalizacao(String entrada) {
  if (entrada == "Grau 1 - Baixíssimo") return "Zona Urbana e Zona Rural";
  if (entrada == "Grau 2 - Baixo") {
    return "Zona Urbana e Zona Rural, exceto perto de hospitais e escolas";
  }
  if (entrada == "Grau 3 - Médio") {
    return "Principais corredores de tráfego (Avenidas e Vias Principais)";
  }
  if (entrada == "Grau 4 - Alto") {
    return "Zona de Expansão da Nova Marabá, Zona de Expansão da Cidade Nova e Zonas Especiais Industriais";
  }
  if (entrada == "Grau 5 - Altíssimo") {
    return "Zonas Especiais Industriais e Zona Rural";
  }
  return "";
}

String getPoluicaoSonora(String entrada) {
  if (entrada == "Grau 1 - Baixíssimo") return "Diurna 50 dB\nNoturna 45 dB";
  if (entrada == "Grau 2 - Baixo") return "Diurna 55 dB\nNoturna 50 dB";
  if (entrada == "Grau 3 - Médio") return "Diurna 60 dB\nNoturna 55 dB";
  if (entrada == "Grau 4 - Alto") return "Diurna 65 dB\nNoturna 60 dB";
  if (entrada == "Grau 5 - Altíssimo") return "70 dB";
  return "";
}

String getPoluicaoAtmosferica(String entrada) {
  if (entrada == "Grau 1 - Baixíssimo") return "Emissão de fumaça";
  if (entrada == "Grau 2 - Baixo") return "Emissão de fumaça";
  if (entrada == "Grau 3 - Médio") {
    return "Emissão de substâncias odoríferas e de fumaça conforme legislação ambiental";
  }
  if (entrada == "Grau 4 - Alto") {
    return "Emissão de substâncias odoríferas e de fumaça conforme legislação ambiental";
  }
  if (entrada == "Grau 5 - Altíssimo") {
    return "Emissão de substâncias odoríferas e de fumaça conforme legislação ambiental";
  }
  return "";
}

String getPoluicaoHidrica(String entrada) {
  if (entrada == "Grau 1 - Baixíssimo") return "Inócuo";
  if (entrada == "Grau 2 - Baixo") return "Inócuo";
  if (entrada == "Grau 3 - Médio") return "Conforme legislação ambiental";
  if (entrada == "Grau 4 - Alto") return "Conforme legislação ambiental";
  if (entrada == "Grau 5 - Altíssimo") return "Conforme legislação ambiental";
  return "";
}

String getGeracaoDeResiduos(String entrada) {
  if (entrada == "Grau 1 - Baixíssimo") return "Classe III";
  if (entrada == "Grau 2 - Baixo") return "Classe III";
  if (entrada == "Grau 3 - Médio") return "Classes II e III";
  if (entrada == "Grau 4 - Alto") return "Classes I e II";
  if (entrada == "Grau 5 - Altíssimo") return "Classe I";
  return "";
}

String getVibracao(String entrada) {
  if (entrada == "Grau 1 - Baixíssimo") return "Não produz";
  if (entrada == "Grau 2 - Baixo") return "Resolve dentro do lote";
  if (entrada == "Grau 3 - Médio") return "Resolve dentro do lote";
  if (entrada == "Grau 4 - Alto") return "Conforme legislação";
  if (entrada == "Grau 5 - Altíssimo") return "Conforme legislação";
  return "";
}

List getCotaAltimetrica(double valor) {
  if (valor < 82) {
    return [
      false,
      "A menor cota altimétrica é $valor m, o limite mínimo é 82m."
    ];
  }

  return [true, "A menor cota altimétrica é $valor m, o limite mínimo é 82m."];
}

List getCoeficienteAproveitamento(
    double value, String outorga, String? nucleo) {
  if (outorga == "Sim") {
    if (value > 4) {
      return [
        false,
        "O Coeficiente de Aproveitamento da edificação é $value, o limite máximo para a localização é 4."
      ];
    }
    return [
      true,
      "O Coeficiente de Aproveitamento da edificação é $value, o limite máximo para a localização é 4."
    ];
  }

  if (nucleo == "Núcleo Marabá Pioneira") {
    if (value > 1.5) {
      return [
        false,
        "O Coeficiente de Aproveitamento da edificação é $value, o limite máximo para a localização é 1.5."
      ];
    }

    return [
      true,
      "O Coeficiente de Aproveitamento da edificação é $value, o limite máximo para a localização é 1.5.",
    ];
  }

  if (value > 1.2) {
    return [
      false,
      "O Coeficiente de Aproveitamento da edificação é $value, o limite máximo para a localização é 1.2."
    ];
  }

  return [
    true,
    "O Coeficiente de Aproveitamento da edificação é $value, o limite máximo para a localização é 1.2."
  ];
}

List getTaxaOcupacao(double value, String zona, String uso, String expansao) {
  if (expansao == "Zona Urbana, em uma Zona de Expansão Urbana") {
    if (value > 60) {
      return [
        false,
        "A Taxa de Ocupação da edificação é $value%, o limite máximo é 60%."
      ];
    }
    return [
      true,
      "A Taxa de Ocupação da edificação é $value%, o limite máximo é 60%."
    ];
  }

  if (zona == "Setor Consolidado") {
    if (uso == "Residencial Multifamiliar") {
      if (value > 60) {
        return [
          false,
          "A Taxa de Ocupação da edificação é $value%, o limite máximo é 60%."
        ];
      }
      return [
        true,
        "A Taxa de Ocupação da edificação é $value%, o limite máximo é 60%."
      ];
    }

    if (value > 70) {
      return [
        false,
        "A Taxa de Ocupação da edificação é $value%, o limite máximo é 70%."
      ];
    }
    return [
      true,
      "A Taxa de Ocupação da edificação é $value%, o limite máximo é 70%."
    ];
  }

  if (zona != "Setor Consolidado") {
    if (uso == "Comercial") {
      if (value > 70) {
        return [
          false,
          "A Taxa de Ocupação da edificação é $value%, o limite máximo é 70%."
        ];
      }
      return [
        true,
        "A Taxa de Ocupação da edificação é $value%, o limite máximo é 70%."
      ];
    }

    if (uso == "Residencial Multifamiliar") {
      if (value > 60) {
        return [
          false,
          "A Taxa de Ocupação da edificação é $value%, o limite máximo é 60%."
        ];
      }
      return [
        true,
        "A Taxa de Ocupação da edificação é $value%, o limite máximo é 60%."
      ];
    }

    if (value > 65) {
      return [
        false,
        "A Taxa de Ocupação da edificação é $value%, o limite máximo é 65%."
      ];
    }
    return [
      true,
      "A Taxa de Ocupação da edificação é $value%, o limite máximo é 65%."
    ];
  }
  return [false, "..."];
}

List getTaxaPermeabilidade(double value) {
  if (value < 20) {
    return [
      false,
      "A Taxa de Permeabilidade do Solo é $value%, o limite mínimo é 20%."
    ];
  }
  return [
    true,
    "A Taxa de Permeabilidade do Solo é $value%, o limite mínimo é 20%."
  ];
}

List getRecuoFrontal(double value, String zona, String uso, String expansao) {
  if (expansao == "Zona Urbana, em uma Zona de Expansão Urbana") {
    if (value < 3) {
      return [
        false,
        "O recuo frontal da edificação é ${value}m, o limite mínimo é 3m."
      ];
    }
    return [
      true,
      "O recuo frontal da edificação é ${value}m, o limite mínimo é 3m."
    ];
  }

  if (uso != "Comercial") {
    if (value < 3) {
      return [
        false,
        "O recuo frontal da edificação é ${value}m, o limite mínimo é 3m."
      ];
    }
    return [
      true,
      "O recuo frontal da edificação é ${value}m, o limite mínimo é 3m."
    ];
  }
  return [
    true,
    "O recuo frontal da edificação é ${value}m, o limite mínimo é 0m."
  ];
}

List getRecuoFundo(double value, String zona, String uso, String expansao) {
  if (expansao == "Zona Urbana, em uma Zona de Expansão Urbana") {
    if (uso == "Residencial Unifamiliar") {
      if (value < 1.5) {
        return [
          false,
          "O recuo de fundo da edificação é ${value}m, o limite mínimo é 1.5m."
        ];
      }
      return [
        true,
        "O recuo de fundo da edificação é ${value}m, o limite mínimo é 1.5m."
      ];
    }

    if (value < 2) {
      return [
        false,
        "O recuo de fundo da edificação é ${value}m, o limite mínimo é 2m."
      ];
    }
    return [
      true,
      "O recuo de fundo da edificação é ${value}m, o limite mínimo é 2m."
    ];
  }

  if (zona != "Setor Consolidado") {
    if (uso == "Residencial Unifamiliar") {
      if (value < 1.5) {
        return [
          false,
          "O recuo de fundo da edificação é ${value}m, o limite mínimo é 1.5m."
        ];
      }
      return [
        true,
        "O recuo de fundo da edificação é ${value}m, o limite mínimo é 1.5m."
      ];
    }

    if (uso == "Residencial Multifamiliar" || uso == "Misto") {
      if (value < 2) {
        return [
          false,
          "O recuo de fundo da edificação é ${value}m, o limite mínimo é 2m."
        ];
      }
      return [
        true,
        "O recuo de fundo da edificação é ${value}m, o limite mínimo é 2m."
      ];
    }

    return [
      true,
      "O recuo de fundo da edificação é ${value}m, o limite mínimo é 0m."
    ];
  }

  if (uso == "Residencial Unifamiliar") {
    if (value < 1.5) {
      return [
        false,
        "O recuo de fundo da edificação é ${value}m, o limite mínimo é 1.5m."
      ];
    }
    return [
      true,
      "O recuo de fundo da edificação é ${value}m, o limite mínimo é 1.5m."
    ];
  }

  if (uso == "Comercial") {
    return [
      true,
      "O recuo de fundo da edificação é ${value}m, o limite mínimo é 0m."
    ];
  }

  if (value < 2) {
    return [
      false,
      "O recuo de fundo da edificação é ${value}m, o limite mínimo é 2m."
    ];
  }
  return [
    true,
    "O recuo de fundo da edificação é ${value}m, o limite mínimo é 2m."
  ];
}

List getRecuoLateralDireita(
    double value, String zona, String uso, String expansao) {
  if (expansao == "Zona Urbana, em uma Zona de Expansão Urbana") {
    if (uso == "Residencial Unifamiliar") {
      if (value < 1.5) {
        return [
          false,
          "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 1.5m"
        ];
      }
      return [
        true,
        "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 1.5m"
      ];
    }

    if (value < 2) {
      return [
        false,
        "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 2m"
      ];
    }
    return [
      true,
      "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 2m"
    ];
  }

  if (zona == "Setor Consolidado") {
    if (uso == "Residencial Unifamiliar") {
      if (value < 1.5) {
        return [
          false,
          "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 1.5m"
        ];
      }
      return [
        true,
        "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 1.5m"
      ];
    }

    if (uso == "Residencial Multifamiliar" || uso == "Misto") {
      if (value < 2) {
        return [
          false,
          "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 2m"
        ];
      }
      return [
        true,
        "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 2m"
      ];
    }

    return [
      true,
      "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 0m"
    ];
  }

  if (uso == "Comercial") {
    return [
      true,
      "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 0m"
    ];
  }

  if (uso == "Residencial Multifamiliar") {
    if (value < 2) {
      return [
        false,
        "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 2m"
      ];
    }
    return [
      true,
      "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 2m"
    ];
  }

  if (value < 1.5) {
    return [
      false,
      "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 1.5m"
    ];
  }
  return [
    true,
    "O recuo da lateral direita da edificação é ${value}m, o limite mínimo é 1.5m"
  ];
}

List getRecuoLateralEsquerda(double value, String uso) {
  if (uso == "Residencial Multifamiliar") {
    if (value < 2) {
      return [
        false,
        "O recuo da lateral esquerda da edificação é ${value}m, o limite mínimo é 2m."
      ];
    }
  }

  return [
    true,
    "O recuo da lateral esquerda da edificação é ${value}m, o limite mínimo é 0m."
  ];
}

List getRecuoLateralEsquina(
    double value, String zona, String uso, String expansao) {
  if (expansao == "Zona Urbana, em uma Zona de Expansão Urbana") {
    if (uso == "Residencial Multifamiliar") {
      if (value < 3) {
        return [
          false,
          "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 3m."
        ];
      }
      return [
        true,
        "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 3m."
      ];
    }

    if (value < 2) {
      return [
        false,
        "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 2m."
      ];
    }
    return [
      true,
      "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 2m."
    ];
  }

  if (zona == "Setor Consolidado") {
    if (uso == "Misto" || uso == "Residencial Unifamiliar") {
      if (value < 2) {
        return [
          false,
          "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 2m."
        ];
      }
      return [
        true,
        "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 2m."
      ];
    }

    if (value < 3) {
      return [
        false,
        "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 3m."
      ];
    }
    return [
      true,
      "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 3m."
    ];
  }

  if (uso == "Comercial") {
    if (value < 3) {
      return [
        false,
        "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 3m."
      ];
    }
    return [
      true,
      "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 3m."
    ];
  }

  if (value < 2) {
    return [
      false,
      "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 2m."
    ];
  }
  return [
    true,
    "O recuo da lateral de esquina da edificação é ${value}m, o limite mínimo é 2m."
  ];
}

List getAlturaEdificacao(double value, double largura, double recuoFrontal) {
  double alturaMaxima = 2.5 * (largura + recuoFrontal);
  if (value > alturaMaxima) {
    return [
      false,
      "A altura da edificação é ${value}m, o limite máximo é ${alturaMaxima.toStringAsFixed(2)}m."
    ];
  }
  return [
    true,
    "A altura da edificação é ${value}m, o limite máximo é ${alturaMaxima.toStringAsFixed(2)}m."
  ];
}

List getLarguraFrente(double value, String zona, String uso, String expansao) {
  if (expansao == "Zona Urbana, em uma Zona de Expansão Urbana") {
    if (uso == "Residencial Multifamiliar") {
      if (value < 15) {
        return [
          false,
          "A largura da frente do lote é ${value}m, o limite mínimo é 15m."
        ];
      }
      return [
        true,
        "A largura da frente do lote é ${value}m, o limite mínimo é 15m."
      ];
    }
  }

  if (zona == "Setor Consolidado") {
    if (uso == "Residencial Unifamiliar") {
      if (value < 10) {
        return [
          false,
          "A largura da frente do lote é ${value}m, o limite mínimo é 10m."
        ];
      }
      return [
        true,
        "A largura da frente do lote é ${value}m, o limite mínimo é 10m."
      ];
    }

    if (value < 15) {
      return [
        false,
        "A largura da frente do lote é ${value}m, o limite mínimo é 15m."
      ];
    }
    return [
      true,
      "A largura da frente do lote é ${value}m, o limite mínimo é 15m."
    ];
  }

  if (uso == "Residencial Unifamiliar") {
    if (value < 10) {
      return [
        false,
        "A largura da frente do lote é ${value}m, o limite mínimo é 10m."
      ];
    }
    return [
      true,
      "A largura da frente do lote é ${value}m, o limite mínimo é 10m."
    ];
  }

  if (uso == "Residencial Multifamiliar") {
    if (value < 30) {
      return [
        false,
        "A largura da frente do lote é ${value}m, o limite mínimo é 30m."
      ];
    }
    return [
      true,
      "A largura da frente do lote é ${value}m, o limite mínimo é 30m."
    ];
  }

  if (value < 15) {
    return [
      false,
      "A largura da frente do lote é ${value}m, o limite mínimo é 15m."
    ];
  }
  return [
    true,
    "A largura da frente do lote é ${value}m, o limite mínimo é 15m."
  ];
}
