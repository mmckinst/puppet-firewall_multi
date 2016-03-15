define firewall_multi (
  $ensure                = undef,
  $action                = undef,
  $burst                 = undef,
  $clusterip_new         = undef,
  $clusterip_hashmode    = undef,
  $clusterip_clustermac  = undef,
  $clusterip_total_nodes = undef,
  $clusterip_local_node  = undef,
  $clusterip_hash_init   = undef,
  $chain                 = undef,
  $checksum_fill         = undef,
  $clamp_mss_to_pmtu     = undef,
  $connlimit_above       = undef,
  $connlimit_mask        = undef,
  $connmark              = undef,
  $ctstate               = undef,
  $date_start            = undef,
  $date_stop             = undef,
  $dport                 = undef,
  $dst_range             = undef,
  $dst_type              = undef,
  $gateway               = undef,
  $gid                   = undef,
  $hop_limit             = undef,
  $icmp                  = undef,
  $iniface               = undef,
  $ipsec_dir             = undef,
  $ipsec_policy          = undef,
  $ipset                 = undef,
  $isfirstfrag           = undef,
  $isfragment            = undef,
  $ishasmorefrags        = undef,
  $islastfrag            = undef,
  $jump                  = undef,
  $kernel_timezone       = undef,
  $limit                 = undef,
  $line                  = undef,
  $log_level             = undef,
  $log_prefix            = undef,
  $log_uid               = undef,
  $mask                  = undef,
  $month_days            = undef,
  $match_mark            = undef,
  $mss                   = undef,
  $outiface              = undef,
  $physdev_in            = undef,
  $physdev_out           = undef,
  $physdev_is_bridged    = undef,
  $pkttype               = undef,
  $proto                 = undef,
  $provider              = undef,
  $random                = undef,
  $rdest                 = undef,
  $reap                  = undef,
  $recent                = undef,
  $reject                = undef,
  $rhitcount             = undef,
  $rname                 = undef,
  $rseconds              = undef,
  $rsource               = undef,
  $rttl                  = undef,
  $set_dscp              = undef,
  $set_dscp_class        = undef,
  $set_mark              = undef,
  $set_mss               = undef,
  $socket                = undef,
  $sport                 = undef,
  $src_range             = undef,
  $src_type              = undef,
  $stat_every            = undef,
  $stat_mode             = undef,
  $stat_packet           = undef,
  $stat_probability      = undef,
  $state                 = undef,
  $table                 = undef,
  $tcp_flags             = undef,
  $time_contiguous       = undef,
  $time_start            = undef,
  $time_stop             = undef,
  $todest                = undef,
  $toports               = undef,
  $tosource              = undef,
  $to                    = undef,
  $uid                   = undef,
  $week_days             = undef,
  # all other arguments are proxied to the puppetlabs/firewall type.
  $source                = undef,
  $destination           = undef,
) {

  if $name =~ /__/ {
    fail("a firewall_multi resource may not contain the string '__'")
  }

  # Welcome to nested loops in Puppet 3 and earlier.
  # We spawn an array of firewall::source resources for each $source.
  # The firewall::source type then spawns an array of firewall::destination
  # resources for each $destination.

  # However, we need to preserve undef values too.  These must be passed
  # as a string 'undef' in the title and will be converted to real undef
  # values later.

  # NOTE: The regsubst function accepts and returns either a string or
  # array of strings.

  if $source {
    $_source = regsubst($source, '(.*)', "${name}__\\1")
  } else {
    $_source = regsubst('undef', '(.*)', "${name}__\\1")
  }

  firewall_multi::source { $_source:
    # I put this here to make the Forge's lint happy.
    ensure                => $ensure,
    # source is passed as a string in the title, see comment above.
    destination           => $destination,
    # all other arguments are proxied to the puppetlabs/firewall type.
    action                => $action,
    burst                 => $burst,
    clusterip_new         => $clusterip_new,
    clusterip_hashmode    => $clusterip_hashmode,
    clusterip_clustermac  => $clusterip_clustermac,
    clusterip_total_nodes => $clusterip_total_nodes,
    clusterip_local_node  => $clusterip_local_node,
    clusterip_hash_init   => $clusterip_hash_init,
    chain                 => $chain,
    checksum_fill         => $checksum_fill,
    clamp_mss_to_pmtu     => $clamp_mss_to_pmtu,
    connlimit_above       => $connlimit_above,
    connlimit_mask        => $connlimit_mask,
    connmark              => $connmark,
    ctstate               => $ctstate,
    date_start            => $date_start,
    date_stop             => $date_stop,
    dport                 => $dport,
    dst_range             => $dst_range,
    dst_type              => $dst_type,
    gateway               => $gateway,
    gid                   => $gid,
    hop_limit             => $hop_limit,
    icmp                  => $icmp,
    iniface               => $iniface,
    ipsec_dir             => $ipsec_dir,
    ipsec_policy          => $ipsec_policy,
    ipset                 => $ipset,
    isfirstfrag           => $isfirstfrag,
    isfragment            => $isfragment,
    ishasmorefrags        => $ishasmorefrags,
    islastfrag            => $islastfrag,
    jump                  => $jump,
    kernel_timezone       => $kernel_timezone,
    limit                 => $limit,
    line                  => $line,
    log_level             => $log_level,
    log_prefix            => $log_prefix,
    log_uid               => $log_uid,
    mask                  => $mask,
    month_days            => $month_days,
    match_mark            => $match_mark,
    mss                   => $mss,
    outiface              => $outiface,
    physdev_in            => $physdev_in,
    physdev_out           => $physdev_out,
    physdev_is_bridged    => $physdev_is_bridged,
    pkttype               => $pkttype,
    proto                 => $proto,
    provider              => $provider,
    random                => $random,
    rdest                 => $rdest,
    reap                  => $reap,
    recent                => $recent,
    reject                => $reject,
    rhitcount             => $rhitcount,
    rname                 => $rname,
    rseconds              => $rseconds,
    rsource               => $rsource,
    rttl                  => $rttl,
    set_dscp              => $set_dscp,
    set_dscp_class        => $set_dscp_class,
    set_mark              => $set_mark,
    set_mss               => $set_mss,
    socket                => $socket,
    sport                 => $sport,
    src_range             => $src_range,
    src_type              => $src_type,
    stat_every            => $stat_every,
    stat_mode             => $stat_mode,
    stat_packet           => $stat_packet,
    stat_probability      => $stat_probability,
    state                 => $state,
    table                 => $table,
    tcp_flags             => $tcp_flags,
    time_contiguous       => $time_contiguous,
    time_start            => $time_start,
    time_stop             => $time_stop,
    todest                => $todest,
    toports               => $toports,
    tosource              => $tosource,
    to                    => $to,
    uid                   => $uid,
    week_days             => $week_days,
  }

}
