class MysqlVersion < Hash

  include Comparable

  attr :str

  def initialize(ver_str)
    raise ArgumentError unless ver_str.is_a?(String) && ver_str =~ /(\d+)\.(\d+)\.(\d+)(-.+)?/

    @str = ver_str

    ver, build = ver_str.split('-')
    ver = ver.split('.')
    self[:major]  = ver[0].to_i
    self[:middle] = ver[1].to_i
    self[:minor]  = ver[2].to_i
    self[:build]  = build
    return self
  end

  def <=>(other)
    other = MysqlVersion.new(other)

    major  = self[:major] <=> other[:major]
    return major unless major == 0

    middle = self[:middle] <=> other[:middle]
    return middle unless middle == 0

    return self[:minor] <=> other[:minor]
  end
  
  def to_s
    @str
  end

end
