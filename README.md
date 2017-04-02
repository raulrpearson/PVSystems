# PVSystems

> A Modelica library for photovoltaic system and power converter design

## Overview

*PVSystems* is a [Modelica](https://modelica.org/) library providing models useful for the design and evaluation of photovoltaic systems and power converters as well as their associated control algorithms. For more information, check out the [online documentation](https://raulrpearson.github.io/PVSystems/).

![Screenshot](PVSystems/Resources/Images/screenshot.png)

The library is the result of a research project carried out in the form of a master's degree thesis. There are two intended audiences for the library:

- **Users**: the library is intended to be rich enough in component and subsystem models that it proves useful for those interested in designing and evaluating photovoltaic systems, power converters and their associated control algorithms. Check out the [usage section](#download-and-usage) to learn more.
- **Developers**: the library is also intended to explore and showcase best practices for the development of Modelica libraries. Many of these best practices are inspired or taken from other [Modelica libraries on GitHub](https://github.com/raulrpearson?language=modelica&tab=stars) and from the excellent [Modelica by Example](http://book.xogeny.com/).

The library is currently in the early stages of development, so the structure and contents will probably be updated regularly. The intention is to provide models in the following categories:

- **Control**: based on the interfaces provided in [Modelica.Blocks](https://github.com/modelica/Modelica/blob/release/Modelica%203.2.2/Blocks/Interfaces.mo), common blocks used in the control of power converters, including Park and Clarke transforms, Space Vector Modulation and grid synchronization blocks.
- **Electrical**: based on the interfaces provided in [Modelica.Electrical.Analog](https://github.com/modelica/Modelica/blob/release/Modelica%203.2.2/Electrical/Analog/Interfaces.mo), common electrical models including PV arrays, energy storage devices, power converters, transformers, loads and other grid elements. The library features both switched and averaged models of power converters.
- **Examples**: a comprehensive set of examples will be provided to showcase the capabilities and explain the use of the library.

## Download and usage

You can grab a copy of the library by clonning the repository or downloading a [zip of the latest commit](https://github.com/raulrpearson/PVSystems/archive/master.zip). Take into account that the library is currently in the early stages of development, so some models might not be stable and the structure and contents of the library will probably be updated regularly. If you want to stay up to date with development, you can [watch the project](https://github.com/raulrpearson/PVSystems/subscription) if you have a GitHub account or you can subscribe to the [commits feed](https://github.com/raulrpearson/PVSystems/commits/master.atom).

The library can be used inside tools like [Dymola](http://www.3ds.com/products-services/catia/products/dymola/) or [OpenModelica](https://openmodelica.org/) to create models of PV systems. These same tools can be used in conjuntion with other tools supporting the [FMI standard](https://fmi-standard.org) for model exchange and co-simulation. For example, a PV system model developed in OpenModelica using this library could then be used to validate a control algorithm developed in MATLAB/Simulink or LabVIEW.

## Contributing

If you have any **questions, comments, suggestions, ideas or feature requests**, please do share those as well as any **mistakes or bugs** you might discover. You can open an issue in the [Issues](https://github.com/raulrpearson/PVSystems/issues) section of the repository or, if you prefer, contact me by [email](mailto:raul.rodriguez.pearson@gmail.com). Contributions in the form of [Pull Requests](https://github.com/raulrpearson/PVSystems/pulls) are always welcome.

## License

PVSystems is licensed under the MIT License. See [LICENSE.md](LICENSE.md) for the full license text.
