module IPTables
  class Builder
    # TODO remap to strings?
    ALIASES = {
      # chain names
      'IN'  => 'INPUT',
      'OUT' => 'OUTPUT',

      # main parameters
      'src' => 'source',

      'iface' => 'in-interface',
      'oface' => 'out-interface',

      # rule parameters
    }
  end
end
