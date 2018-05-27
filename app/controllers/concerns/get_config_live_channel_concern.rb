module GetConfigLiveChannelConcern
  extend ActiveSupport::Concern

  def get_config_live_channel(user_id, endpoint_a, endpoint_b, input_id)
  {
    destinations: [
      {
        id: "destination1",
        settings: [
          {
            password_param: endpoint_a[:password_param],
            url: endpoint_a[:url],
            username: endpoint_a[:username],
          },
          {
            password_param: endpoint_b[:password_param],
            url: endpoint_b[:url],
            username: endpoint_b[:username],
          }
        ],
      },
      {
        "id": "xglbca",
        "settings": [
          {
            "url": "s3ssl://liveup-aws-archives/input/%s/liveup-stream" % user_id
          },
          {
            "url": "s3ssl://liveup-aws-archives/input/user-fake/test"
          }
        ]
      }
    ],
    "encoder_settings": {
      "audio_descriptions": [
        {
          "audio_selector_name": "Default",
          "codec_settings": {
            "aac_settings": {
              "input_type": "NORMAL",
              "bitrate": 192000,
              "coding_mode": "CODING_MODE_2_0",
              "raw_format": "NONE",
              "spec": "MPEG4",
              "profile": "LC",
              "rate_control_mode": "CBR",
              "sample_rate": 48000
            }
          },
          "audio_type_control": "FOLLOW_INPUT",
          "language_code_control": "FOLLOW_INPUT",
          "name": "audio_1"
        },
        {
          "audio_selector_name": "Default",
          "codec_settings": {
            "aac_settings": {
              "input_type": "NORMAL",
              "bitrate": 192000,
              "coding_mode": "CODING_MODE_2_0",
              "raw_format": "NONE",
              "spec": "MPEG4",
              "profile": "LC",
              "rate_control_mode": "CBR",
              "sample_rate": 48000
            }
          },
          "audio_type_control": "FOLLOW_INPUT",
          "language_code_control": "FOLLOW_INPUT",
          "name": "audio_2"
        },
        {
          "audio_selector_name": "Default",
          "codec_settings": {
            "aac_settings": {
              "input_type": "NORMAL",
              "bitrate": 128000,
              "coding_mode": "CODING_MODE_2_0",
              "raw_format": "NONE",
              "spec": "MPEG4",
              "profile": "LC",
              "rate_control_mode": "CBR",
              "sample_rate": 48000
            }
          },
          "audio_type_control": "FOLLOW_INPUT",
          "language_code_control": "FOLLOW_INPUT",
          "name": "audio_3"
        },
        {
          "audio_selector_name": "Default",
          "codec_settings": {
            "aac_settings": {
              "input_type": "NORMAL",
              "bitrate": 128000,
              "coding_mode": "CODING_MODE_2_0",
              "raw_format": "NONE",
              "spec": "MPEG4",
              "profile": "LC",
              "rate_control_mode": "CBR",
              "sample_rate": 48000
            }
          },
          "audio_type_control": "FOLLOW_INPUT",
          "language_code_control": "FOLLOW_INPUT",
          "name": "audio_4"
        },
        {
          "audio_selector_name": "Default",
          "audio_type_control": "FOLLOW_INPUT",
          "language_code_control": "FOLLOW_INPUT",
          "name": "audio_opmc0b"
        }
      ],
      "caption_descriptions": [],
      "output_groups": [
        {
          "output_group_settings": {
            "hls_group_settings": {
              "ad_markers": [],
              "caption_language_setting": "OMIT",
              "caption_language_mappings": [],
              "hls_cdn_settings": {
                "hls_webdav_settings": {
                  "num_retries": 10,
                  "connection_retry_interval": 1,
                  "restart_delay": 15,
                  "filecache_duration": 300,
                  "http_transfer_mode": "NON_CHUNKED"
                }
              },
              "input_loss_action": "EMIT_OUTPUT",
              "manifest_compression": "NONE",
              "destination": {
                "destination_ref_id": "destination1"
              },
              "iv_in_manifest": "INCLUDE",
              "iv_source": "FOLLOWS_SEGMENT_NUMBER",
              "client_cache": "ENABLED",
              "ts_file_mode": "SEGMENTED_FILES",
              "manifest_duration_format": "INTEGER",
              "segmentation_mode": "USE_SEGMENT_DURATION",
              "output_selection": "MANIFESTS_AND_SEGMENTS",
              "stream_inf_resolution": "INCLUDE",
              "index_n_segments": 10,
              "program_date_time": "EXCLUDE",
              "program_date_time_period": 600,
              "keep_segments": 21,
              "segment_length": 6,
              "timed_metadata_id_3_frame": "PRIV",
              "timed_metadata_id_3_period": 10,
              "codec_specification": "RFC_4281",
              "directory_structure": "SINGLE_DIRECTORY",
              "segments_per_subdirectory": 10000,
              "mode": "LIVE"
            }
          },
          "name": "HD",
          "outputs": [
            {
              "output_settings": {
                "hls_output_settings": {
                  "name_modifier": "_1080p30",
                  "hls_settings": {
                    "standard_hls_settings": {
                      "m3u_8_settings": {
                        "audio_frames_per_pes": 4,
                        "audio_pids": "492-498",
                        "ecm_pid": "8182",
                        "pcr_control": "PCR_EVERY_PES_PACKET",
                        "pmt_pid": "480",
                        "program_num": 1,
                        "scte_35_pid": "500",
                        "scte_35_behavior": "NO_PASSTHROUGH",
                        "timed_metadata_pid": "502",
                        "timed_metadata_behavior": "NO_PASSTHROUGH",
                        "video_pid": "481"
                      },
                      "audio_rendition_sets": "PROGRAM_AUDIO"
                    }
                  }
                }
              },
              "video_description_name": "video_1080p30",
              "audio_description_names": [
                "audio_1"
              ],
              "caption_description_names": []
            },
            {
              "output_settings": {
                "hls_output_settings": {
                  "name_modifier": "_720p30",
                  "hls_settings": {
                    "standard_hls_settings": {
                      "m3u_8_settings": {
                        "audio_frames_per_pes": 4,
                        "audio_pids": "492-498",
                        "ecm_pid": "8182",
                        "pcr_control": "PCR_EVERY_PES_PACKET",
                        "pmt_pid": "480",
                        "program_num": 1,
                        "scte_35_pid": "500",
                        "scte_35_behavior": "NO_PASSTHROUGH",
                        "timed_metadata_pid": "502",
                        "timed_metadata_behavior": "NO_PASSTHROUGH",
                        "video_pid": "481"
                      },
                      "audio_rendition_sets": "PROGRAM_AUDIO"
                    }
                  }
                }
              },
              "video_description_name": "video_720p30",
              "audio_description_names": [
                "audio_2"
              ],
              "caption_description_names": []
            },
            {
              "output_settings": {
                "hls_output_settings": {
                  "name_modifier": "_480p30",
                  "hls_settings": {
                    "standard_hls_settings": {
                      "m3u_8_settings": {
                        "audio_frames_per_pes": 4,
                        "audio_pids": "492-498",
                        "ecm_pid": "8182",
                        "pcr_control": "PCR_EVERY_PES_PACKET",
                        "pmt_pid": "480",
                        "program_num": 1,
                        "scte_35_pid": "500",
                        "scte_35_behavior": "NO_PASSTHROUGH",
                        "timed_metadata_pid": "502",
                        "timed_metadata_behavior": "NO_PASSTHROUGH",
                        "video_pid": "481"
                      },
                      "audio_rendition_sets": "PROGRAM_AUDIO"
                    }
                  }
                }
              },
              "video_description_name": "video_480p30",
              "audio_description_names": [
                "audio_3"
              ],
              "caption_description_names": []
            },
            {
              "output_settings": {
                "hls_output_settings": {
                  "name_modifier": "_240p30",
                  "hls_settings": {
                    "standard_hls_settings": {
                      "m3u_8_settings": {
                        "audio_frames_per_pes": 4,
                        "audio_pids": "492-498",
                        "ecm_pid": "8182",
                        "pcr_control": "PCR_EVERY_PES_PACKET",
                        "pmt_pid": "480",
                        "program_num": 1,
                        "scte_35_pid": "500",
                        "scte_35_behavior": "NO_PASSTHROUGH",
                        "timed_metadata_pid": "502",
                        "timed_metadata_behavior": "NO_PASSTHROUGH",
                        "video_pid": "481"
                      },
                      "audio_rendition_sets": "PROGRAM_AUDIO"
                    }
                  }
                }
              },
              "video_description_name": "video_240p30",
              "audio_description_names": [
                "audio_4"
              ],
              "caption_description_names": []
            }
          ]
        },
        {
          "output_group_settings": {
            "archive_group_settings": {
              "destination": {
                "destination_ref_id": "xglbca"
              },
              "rollover_interval": 300
            }
          },
          "name": "FourthTestA",
          "outputs": [
            {
              "output_settings": {
                "archive_output_settings": {
                  "name_modifier": "_$dt$",
                  "container_settings": {
                    "m2ts_settings": {
                      "cc_descriptor": "DISABLED",
                      "ebif": "NONE",
                      "program_num": 1,
                      "pat_interval": 100,
                      "pmt_interval": 100,
                      "pcr_control": "PCR_EVERY_PES_PACKET",
                      "pcr_period": 40,
                      "timed_metadata_behavior": "NO_PASSTHROUGH",
                      "buffer_model": "MULTIPLEX",
                      "rate_mode": "CBR",
                      "audio_buffer_model": "ATSC",
                      "audio_stream_type": "DVB",
                      "audio_frames_per_pes": 2,
                      "segmentation_style": "MAINTAIN_CADENCE",
                      "segmentation_markers": "NONE",
                      "ebp_placement": "VIDEO_AND_AUDIO_PIDS",
                      "ebp_audio_interval": "VIDEO_INTERVAL",
                      "es_rate_in_pes": "EXCLUDE",
                      "arib": "DISABLED",
                      "arib_captions_pid_control": "AUTO",
                      "absent_input_audio_behavior": "ENCODE_SILENCE",
                      "pmt_pid": "480",
                      "video_pid": "481",
                      "audio_pids": "482-498",
                      "dvb_teletext_pid": "499",
                      "dvb_sub_pids": "460-479",
                      "scte_27_pids": "450-459",
                      "scte_35_pid": "500",
                      "scte_35_control": "NONE",
                      "klv": "NONE",
                      "klv_data_pids": "501",
                      "timed_metadata_pid": "502",
                      "etv_platform_pid": "504",
                      "etv_signal_pid": "505",
                      "ecm_pid": "506",
                      "arib_captions_pid": "507"
                    }
                  }
                }
              },
              "output_name": "bxlem8",
              "video_description_name": "video_ex1s7",
              "audio_description_names": [
                "audio_opmc0b"
              ],
              "caption_description_names": []
            }
          ]
        }
      ],
      "timecode_config": {
        "source": "EMBEDDED"
      },
      "video_descriptions": [
        {
          "codec_settings": {
            "h264_settings": {
              "afd_signaling": "NONE",
              "color_metadata": "INSERT",
              "adaptive_quantization": "HIGH",
              "bitrate": 5000000,
              "entropy_encoding": "CABAC",
              "flicker_aq": "ENABLED",
              "framerate_control": "SPECIFIED",
              "framerate_numerator": 30,
              "framerate_denominator": 1,
              "gop_b_reference": "ENABLED",
              "gop_closed_cadence": 1,
              "gop_num_b_frames": 3,
              "gop_size": 60,
              "gop_size_units": "FRAMES",
              "scan_type": "PROGRESSIVE",
              "level": "H264_LEVEL_AUTO",
              "look_ahead_rate_control": "HIGH",
              "num_ref_frames": 3,
              "par_control": "INITIALIZE_FROM_SOURCE",
              "profile": "HIGH",
              "rate_control_mode": "CBR",
              "syntax": "DEFAULT",
              "scene_change_detect": "ENABLED",
              "slices": 1,
              "spatial_aq": "ENABLED",
              "temporal_aq": "ENABLED",
              "timecode_insertion": "DISABLED"
            }
          },
          "height": 1080,
          "name": "video_1080p30",
          "respond_to_afd": "NONE",
          "sharpness": 50,
          "scaling_behavior": "DEFAULT",
          "width": 1920
        },
        {
          "codec_settings": {
            "h264_settings": {
              "afd_signaling": "NONE",
              "color_metadata": "INSERT",
              "adaptive_quantization": "HIGH",
              "bitrate": 3000000,
              "entropy_encoding": "CABAC",
              "flicker_aq": "ENABLED",
              "framerate_control": "SPECIFIED",
              "framerate_numerator": 30,
              "framerate_denominator": 1,
              "gop_b_reference": "ENABLED",
              "gop_closed_cadence": 1,
              "gop_num_b_frames": 3,
              "gop_size": 60,
              "gop_size_units": "FRAMES",
              "scan_type": "PROGRESSIVE",
              "level": "H264_LEVEL_AUTO",
              "look_ahead_rate_control": "HIGH",
              "num_ref_frames": 3,
              "par_control": "INITIALIZE_FROM_SOURCE",
              "profile": "HIGH",
              "rate_control_mode": "CBR",
              "syntax": "DEFAULT",
              "scene_change_detect": "ENABLED",
              "slices": 1,
              "spatial_aq": "ENABLED",
              "temporal_aq": "ENABLED",
              "timecode_insertion": "DISABLED"
            }
          },
          "height": 720,
          "name": "video_720p30",
          "respond_to_afd": "NONE",
          "sharpness": 100,
          "scaling_behavior": "DEFAULT",
          "width": 1280
        },
        {
          "codec_settings": {
            "h264_settings": {
              "afd_signaling": "NONE",
              "color_metadata": "INSERT",
              "adaptive_quantization": "HIGH",
              "bitrate": 1500000,
              "entropy_encoding": "CABAC",
              "flicker_aq": "ENABLED",
              "framerate_control": "SPECIFIED",
              "framerate_numerator": 30,
              "framerate_denominator": 1,
              "gop_b_reference": "ENABLED",
              "gop_closed_cadence": 1,
              "gop_num_b_frames": 3,
              "gop_size": 60,
              "gop_size_units": "FRAMES",
              "scan_type": "PROGRESSIVE",
              "level": "H264_LEVEL_AUTO",
              "look_ahead_rate_control": "HIGH",
              "num_ref_frames": 3,
              "par_control": "SPECIFIED",
              "par_numerator": 4,
              "par_denominator": 3,
              "profile": "MAIN",
              "rate_control_mode": "CBR",
              "syntax": "DEFAULT",
              "scene_change_detect": "ENABLED",
              "slices": 1,
              "spatial_aq": "ENABLED",
              "temporal_aq": "ENABLED",
              "timecode_insertion": "DISABLED"
            }
          },
          "height": 480,
          "name": "video_480p30",
          "respond_to_afd": "NONE",
          "sharpness": 100,
          "scaling_behavior": "STRETCH_TO_OUTPUT",
          "width": 640
        },
        {
          "codec_settings": {
            "h264_settings": {
              "afd_signaling": "NONE",
              "color_metadata": "INSERT",
              "adaptive_quantization": "HIGH",
              "bitrate": 750000,
              "entropy_encoding": "CABAC",
              "flicker_aq": "ENABLED",
              "framerate_control": "SPECIFIED",
              "framerate_numerator": 30,
              "framerate_denominator": 1,
              "gop_b_reference": "ENABLED",
              "gop_closed_cadence": 1,
              "gop_num_b_frames": 3,
              "gop_size": 60,
              "gop_size_units": "FRAMES",
              "scan_type": "PROGRESSIVE",
              "level": "H264_LEVEL_AUTO",
              "look_ahead_rate_control": "HIGH",
              "num_ref_frames": 3,
              "par_control": "SPECIFIED",
              "par_numerator": 4,
              "par_denominator": 3,
              "profile": "MAIN",
              "rate_control_mode": "CBR",
              "syntax": "DEFAULT",
              "scene_change_detect": "ENABLED",
              "slices": 1,
              "spatial_aq": "ENABLED",
              "temporal_aq": "ENABLED",
              "timecode_insertion": "DISABLED"
            }
          },
          "height": 240,
          "name": "video_240p30",
          "respond_to_afd": "NONE",
          "sharpness": 100,
          "scaling_behavior": "STRETCH_TO_OUTPUT",
          "width": 320
        },
        {
          "codec_settings": {
            "h264_settings": {
              "afd_signaling": "NONE",
              "color_metadata": "INSERT",
              "adaptive_quantization": "MEDIUM",
              "bitrate": 5000000,
              "entropy_encoding": "CABAC",
              "flicker_aq": "ENABLED",
              "framerate_control": "INITIALIZE_FROM_SOURCE",
              "gop_b_reference": "DISABLED",
              "gop_closed_cadence": 1,
              "gop_num_b_frames": 2,
              "gop_size": 90,
              "gop_size_units": "FRAMES",
              "scan_type": "PROGRESSIVE",
              "level": "H264_LEVEL_AUTO",
              "look_ahead_rate_control": "MEDIUM",
              "num_ref_frames": 1,
              "par_control": "INITIALIZE_FROM_SOURCE",
              "profile": "MAIN",
              "rate_control_mode": "CBR",
              "syntax": "DEFAULT",
              "scene_change_detect": "ENABLED",
              "spatial_aq": "ENABLED",
              "temporal_aq": "ENABLED",
              "timecode_insertion": "DISABLED"
            }
          },
          "name": "video_ex1s7",
          "respond_to_afd": "NONE",
          "sharpness": 50,
          "scaling_behavior": "DEFAULT"
        }
      ]
    },
    input_attachments: [
      {
      	input_id: input_id,
  			"input_settings": {
          "network_input_settings": {
            "server_validation": "CHECK_CRYPTOGRAPHY_AND_VALIDATE_NAME"
          },
          "source_end_behavior": "CONTINUE",
          "input_filter": "AUTO",
          "filter_strength": 1,
          "deblock_filter": "DISABLED",
          "denoise_filter": "DISABLED",
          "audio_selectors": [],
          "caption_selectors": [
            {
              "selector_settings": {
                "embedded_source_settings": {
                  "source_608_channel_number": 1,
                  "source_608_track_number": 1,
                  "convert_608_to_708": "DISABLED",
                  "scte_20_detection": "OFF"
                }
              },
              "name": "EmbeddedSelector"
            }
          ]
        }
      },
    ],
    input_specification: {
      codec: "AVC", # accepts MPEG2, AVC, HEVC
      maximum_bitrate: "MAX_20_MBPS", # accepts MAX_10_MBPS, MAX_20_MBPS, MAX_50_MBPS
      resolution: "HD", # accepts SD, HD, UHD
    },
    name: "%s-LiveupChannelLive" % user_id,
    role_arn: "arn:aws:iam::313471881687:role/MediaLiveAccessRole",
  }
  end
end
