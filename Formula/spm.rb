class Spm < Formula
  desc "spm-pod"
  homepage "https://github.com/RunsCode/homebrew-spm"
  url "https://github.com/RunsCode/homebrew-spm/releases/download/0.0.1/0.0.1.tar.gz"
  sha256 "71e00dfc962f996739b43e162df7650682689e2fd585ed4ea1d1e83f15c88fef"
  license "MIT"

  # depends_on "cmake" => :build

  def install

    bin.install "spm"
  end

  test do
    system "false"
  end
end
